Return-path: <klimov.linux@gmail.com>
MIME-Version: 1.0
In-Reply-To: <56E7727B.3070303@roeck-us.net>
References: <1457576946-9313-1-git-send-email-klimov.linux@gmail.com>
	<56E0EFD8.20206@roeck-us.net>
	<CALW4P+Km7csSRgS5gBQz+B1mrpGy=aUF-yGZbd2EPNPcVabNow@mail.gmail.com>
	<56E7727B.3070303@roeck-us.net>
Date: Wed, 16 Mar 2016 01:11:53 +0000
Message-ID: <CALW4P+LmQngRAyWkUuqTR4WUnO3z+B_zf=i5arVqCB6_cYDNCA@mail.gmail.com>
Subject: Re: [PATCH] watchdog: add driver for StreamLabs USB watchdog device
From: Alexey Klimov <klimov.linux@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
	wim@iguana.be, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Yury Norov <yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

On Tue, Mar 15, 2016 at 2:24 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> Hi Alexey,
>
>
> On 03/14/2016 06:02 PM, Alexey Klimov wrote:
>>
>> Hi Guenter,
>>
>> On Thu, Mar 10, 2016 at 3:54 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> On 03/09/2016 06:29 PM, Alexey Klimov wrote:
>>>>
>>>>
>>>> This patch creates new driver that supports StreamLabs usb watchdog
>>>> device. This device plugs into 9-pin usb header and connects to
>>>> reset pin and reset button on common PC.
>>>>
>>>> USB commands used to communicate with device were reverse
>>>> engineered using usbmon.
>>>>
>>>> Signed-off-by: Alexey Klimov <klimov.linux@gmail.com>
>>>> ---
>>>>    drivers/watchdog/Kconfig          |  15 ++
>>>>    drivers/watchdog/Makefile         |   1 +
>>>>    drivers/watchdog/streamlabs_wdt.c | 370
>>>> ++++++++++++++++++++++++++++++++++++++
>>>>    3 files changed, 386 insertions(+)

[...]

>>>> +static int usb_streamlabs_wdt_command(struct watchdog_device *wdt_dev,
>>>> int cmd)
>>>> +{
>>>> +       struct streamlabs_wdt *streamlabs_wdt =
>>>> watchdog_get_drvdata(wdt_dev);
>>>> +       int retval;
>>>> +       int size;
>>>> +       unsigned long timeout_msec;
>>>> +       int retry_counter = 10;         /* how many times to re-send
>>>> stop
>>>> cmd */
>>>> +
>>>> +       mutex_lock(&streamlabs_wdt->lock);
>>>> +
>>>> +       timeout_msec = wdt_dev->timeout * MSEC_PER_SEC;
>>>> +
>>>> +       /* Prepare message that will be sent to device.
>>>> +        * This buffer is allocated by kzalloc(). Only initialize
>>>> required
>>>> +        * fields.
>>>
>>>
>>>
>>> But only once, and overwritten by the response. So the comment is quite
>>> pointless
>>> and misleading.
>>
>>
>> Ok, I will do something with this comment during re-work and rebase.
>>
>>>> +        */
>>>> +       if (cmd == STREAMLABS_CMD_START) {
>>>> +               streamlabs_wdt->buffer[0] = 0xcc;
>>>> +               streamlabs_wdt->buffer[1] = 0xaa;
>>>> +       } else {        /* assume stop command if it's not start */
>>>> +               streamlabs_wdt->buffer[0] = 0xff;
>>>> +               streamlabs_wdt->buffer[1] = 0xbb;
>>>> +       }
>>>> +
>>>> +       streamlabs_wdt->buffer[3] = 0x80;
>>>> +
>>>> +       streamlabs_wdt->buffer[6] = (timeout_msec & 0xff) << 8;
>>>> +       streamlabs_wdt->buffer[7] = (timeout_msec & 0xff00) >> 8;
>>>> +retry:
>>>> +       streamlabs_wdt->buffer[10] = 0x00;
>>>> +       streamlabs_wdt->buffer[11] = 0x00;
>>>> +       streamlabs_wdt->buffer[12] = 0x00;
>>>> +       streamlabs_wdt->buffer[13] = 0x00;
>>>> +
>>>> +       /* send command to watchdog */
>>>> +       retval = usb_interrupt_msg(streamlabs_wdt->usbdev,
>>>> +                               usb_sndintpipe(streamlabs_wdt->usbdev,
>>>> 0x02),
>>>> +                               streamlabs_wdt->buffer,
>>>> BUFFER_TRANSFER_LENGTH,
>>>> +                               &size, USB_TIMEOUT);
>>>> +
>>>> +       if (retval || size != BUFFER_TRANSFER_LENGTH) {
>>>> +               dev_err(&streamlabs_wdt->intf->dev,
>>>> +                       "error %i when submitting interrupt msg\n",
>>>> retval);
>>>
>>>
>>>
>>> Please no error messages if something goes wrong. We don't want to
>>> fill the kernel log with those messages.
>>
>>
>> Ok, will remove them. Or is it fine to convert them to dev_dbg?
>>
>
> If you think the messages might be useful for debugging, sure.

Well, definetely they help me now.

>>>> +               retval = -EIO;
>>>> +               goto out;
>>>> +       }
>>>> +
>>>> +       /* and read response from watchdog */
>>>> +       retval = usb_interrupt_msg(streamlabs_wdt->usbdev,
>>>> +                               usb_rcvintpipe(streamlabs_wdt->usbdev,
>>>> 0x81),
>>>> +                               streamlabs_wdt->buffer, BUFFER_LENGTH,
>>>> +                               &size, USB_TIMEOUT);
>>>> +
>>>> +       if (retval || size != BUFFER_LENGTH) {
>>>> +               dev_err(&streamlabs_wdt->intf->dev,
>>>> +                       "error %i when receiving interrupt msg\n",
>>>> retval);
>>>> +               retval = -EIO;
>>>> +               goto out;
>>>> +       }
>>>> +
>>>> +       /* check if watchdog actually acked/recognized command */
>>>> +       retval =
>>>> usb_streamlabs_wdt_validate_response(streamlabs_wdt->buffer);
>>>> +       if (retval) {
>>>> +               dev_err(&streamlabs_wdt->intf->dev,
>>>> +                                       "watchdog didn't ACK
>>>> command!\n");
>>>> +               goto out;
>>>> +       }
>>>> +
>>>> +       /* Transition from enabled to disabled state in this device
>>>> +        * doesn't happen immediately. Usually, 2 or 3 (sometimes even
>>>> 4)
>>>> stop
>>>> +        * commands should be sent until watchdog answers 'I'm
>>>> stopped!'.
>>>> +        * Retry stop command if watchdog fails to answer correctly
>>>> +        * about its state. After 10 attempts, report error and return
>>>> -EIO.
>>>> +        */
>>>> +       if (cmd == STREAMLABS_CMD_STOP) {
>>>> +               if (--retry_counter <= 0) {
>>>> +                       dev_err(&streamlabs_wdt->intf->dev,
>>>> +                               "failed to stop watchdog after 9
>>>> attempts!\n");
>>>> +                       retval = -EIO;
>>>> +                       goto out;
>>>> +               }
>>>> +               /*
>>>> +                * Check if watchdog actually changed state to disabled.
>>>> +                * If watchdog is still enabled then reset message and
>>>> retry
>>>> +                * stop command.
>>>> +                */
>>>> +               if (streamlabs_wdt->buffer[0] != 0xff ||
>>>> +                                       streamlabs_wdt->buffer[1] !=
>>>> 0xbb)
>>>> {
>>>> +                       streamlabs_wdt->buffer[0] = 0xff;
>>>> +                       streamlabs_wdt->buffer[1] = 0xbb;
>>>> +                       goto retry;
>>>
>>>
>>>
>>> Can you use a loop instead ? goto's are ok when needed,
>>> but here it just makes the code more difficult to read.
>>
>>
>> Sure.
>>
>>>> +               }
>>>> +       }
>>>> +
>>>> +out:
>>>> +       mutex_unlock(&streamlabs_wdt->lock);
>>>> +       return retval;
>>>> +}
>>>> +
>>>> +static int usb_streamlabs_wdt_start(struct watchdog_device *wdt_dev)
>>>> +{
>>>> +       return usb_streamlabs_wdt_command(wdt_dev,
>>>> STREAMLABS_CMD_START);
>>>> +}
>>>> +
>>>> +static int usb_streamlabs_wdt_stop(struct watchdog_device *wdt_dev)
>>>> +{
>>>> +       return usb_streamlabs_wdt_command(wdt_dev, STREAMLABS_CMD_STOP);
>>>> +}
>>>> +
>>>> +static int usb_streamlabs_wdt_settimeout(struct watchdog_device
>>>> *wdt_dev,
>>>> +                               unsigned int timeout)
>>>> +{
>>>> +       struct streamlabs_wdt *streamlabs_wdt =
>>>> watchdog_get_drvdata(wdt_dev);
>>>> +
>>>> +       mutex_lock(&streamlabs_wdt->lock);
>>>> +       wdt_dev->timeout = timeout;
>>>> +       mutex_unlock(&streamlabs_wdt->lock);
>>>
>>>
>>>
>>> I don't think this mutex protection is needed.
>>>
>>> Note that there is a patch pending (and will make it into 4.6)
>>> which will make the set_timeout function optional if all it does
>>> is to set the timeout variable.
>>
>>
>> Here comes some pain. For last week I tried to clone
>> git://www.linux-watchdog.org/linux-watchdog-next.git (I hope this is
>> correct address) to rebase on top of 4.6 and test but almost always I
>> got this after counting:
>>
>> fatal: read error: Connection timed out
>> fatal: early EOF
>> fatal: index-pack failed
>>
>> and counting takes 3-4 hours.
>>
>> After all I cloned it (and www.linux-watchdog.org looks more healthy
>> in last couple of days) but merge window should be opened soon so I
>> will get new things in two weeks anyway. I think I will be able to
>> rebase on 4.6-rc1 or near and re-send.
>>
>> Looks like I'm not the first one who have troubles with
>> git://www.linux-watchdog.org
>> http://www.spinics.net/lists/linux-watchdog/msg07384.html
>>
>
> Yes, sometimes Wim's service provider seems to be less than reliable.
>
> If that happens, you can clone
>
> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
> and check out the watchdog-next branch. It is not in sync with Wim's tree,
> though,
> and typically has a few commits on top of it (or, once in a while, may be
> missing
> some commits).

Thanks for sharing this link.
Give me few more days or probably on weekend I will try to send
rebased and re-tested v 2.

[...]

>>>> +
>>>> +
>>>> +static int usb_streamlabs_wdt_suspend(struct usb_interface *intf,
>>>> +                                       pm_message_t message)
>>>> +{
>>>> +       struct streamlabs_wdt *streamlabs_wdt = usb_get_intfdata(intf);
>>>> +
>>>> +       if (watchdog_active(&streamlabs_wdt->wdt_dev))
>>>> +               usb_streamlabs_wdt_command(&streamlabs_wdt->wdt_dev,
>>>> +
>>>> STREAMLABS_CMD_STOP);
>>>
>>>
>>>
>>> Please call usb_streamlabs_wdt_stop().
>>>
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static int usb_streamlabs_wdt_resume(struct usb_interface *intf)
>>>> +{
>>>> +       struct streamlabs_wdt *streamlabs_wdt = usb_get_intfdata(intf);
>>>> +
>>>> +       if (watchdog_active(&streamlabs_wdt->wdt_dev))
>>>> +               return
>>>> usb_streamlabs_wdt_command(&streamlabs_wdt->wdt_dev,
>>>> +
>>>> STREAMLABS_CMD_START);
>>>
>>>
>>>
>>> Please call usb_streamlabs_wdt_start().
>>
>>
>> Thanks, I will add required calls. Out of curiosity, what about
>> driver(s) that checks watchdog status in suspend/resume and calls
>> stop/start only if watchdog active?
>>
>
> Not sure I understand. Isn't that what you are doing ?

Ouch. Nevermind. I must be dreaming during night-time when I wrote this.
I will change this calls to usb_streamlabs_wdt_{stop,start} as you pointed.

>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static void usb_streamlabs_wdt_disconnect(struct usb_interface *intf)
>>>> +{
>>>> +       struct streamlabs_wdt *streamlabs_wdt = usb_get_intfdata(intf);
>>>> +
>>>> +       /* First, stop sending USB messages to device. */
>>>> +       mutex_lock(&streamlabs_wdt->lock);
>>>> +       usb_set_intfdata(intf, NULL);
>>>> +       streamlabs_wdt->usbdev = NULL;
>>>> +       mutex_unlock(&streamlabs_wdt->lock);
>>>> +
>>>
>>>
>>> If user space has a keepalive pending (waiting for the mutex being
>>> released in usb_streamlabs_wdt_command()), this may result in a call to
>>> usb_interrupt_msg() with the device set to NULL. The mutex protection
>>> doesn't add any value since you don't check if ->usbdev is NULL in
>>> usb_streamlabs_wdt_command().
>>
>>
>> In another email Oliver adviced to remove ->usbdev. So, I use ->intf
>> and check it for NULL in usb_streamlabs_wdt_command(). I also do
>> usb_set_intfdata(intf, NULL);
>> streamlabs_wdt->intf = NULL;
>> here with mutex locked. Hope it's fine.
>>
>
> I'll have to see the code to determine if it is clean.

I'm working on it. Please let me know if migrating to u16 buffer array
is not acceptable way.


Thanks!

-- 
Best regards, Klimov Alexey
