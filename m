Return-path: <abrestic@google.com>
MIME-Version: 1.0
Sender: abrestic@google.com
In-Reply-To: <20150401222218.GB13077@jhogan-linux.le.imgtec.org>
References: <1427910196-28568-1-git-send-email-abrestic@chromium.org>
	<20150401222218.GB13077@jhogan-linux.le.imgtec.org>
Date: Wed, 1 Apr 2015 15:42:25 -0700
Message-ID: <CAL1qeaEAY_T4Ba9Gr0zQcr-d+oHmGxY9P5AD019vkSEV6y3MJg@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] watchdog: imgpdc: Allow timeout to be set in device-tree
From: Andrew Bresticker <abrestic@chromium.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi James,

On Wed, Apr 1, 2015 at 3:22 PM, James Hogan <james.hogan@imgtec.com> wrote:
> Hi Andrew,
>
> On Wed, Apr 01, 2015 at 10:43:14AM -0700, Andrew Bresticker wrote:
>> Since the heartbeat is statically initialized to its default value,
>> watchdog_init_timeout() will never look in the device-tree for a
>> timeout-sec value.  Instead of statically initializing heartbeat,
>> fall back to the default timeout value if watchdog_init_timeout()
>> fails.
>
> Whoops. Sorry about that. I wasn't aware that a timeout-sec value was
> expected. It isn't mentioned in the DT binding documentation for this
> device :-(.

I didn't notice it was broken either until Guenter pointed it out :).
Not sure I agree with timeout-sec even being DT property, but many
other drivers already support it so we might as well too.

>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>> Cc: James Hogan <james.hogan@imgtec.com>
>> ---
>> New for v2.
>> ---
>>  drivers/watchdog/imgpdc_wdt.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
>> index 0deaa4f..89b2abc 100644
>> --- a/drivers/watchdog/imgpdc_wdt.c
>> +++ b/drivers/watchdog/imgpdc_wdt.c
>> @@ -42,7 +42,7 @@
>>  #define PDC_WDT_MIN_TIMEOUT          1
>>  #define PDC_WDT_DEF_TIMEOUT          64
>>
>> -static int heartbeat = PDC_WDT_DEF_TIMEOUT;
>> +static int heartbeat;
>>  module_param(heartbeat, int, 0);
>>  MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds "
>>       "(default=" __MODULE_STRING(PDC_WDT_DEF_TIMEOUT) ")");
>> @@ -195,9 +195,9 @@ static int pdc_wdt_probe(struct platform_device *pdev)
>>
>>       ret = watchdog_init_timeout(&pdc_wdt->wdt_dev, heartbeat, &pdev->dev);
>>       if (ret < 0) {
>> -             pdc_wdt->wdt_dev.timeout = pdc_wdt->wdt_dev.max_timeout;
>> +             pdc_wdt->wdt_dev.timeout = PDC_WDT_DEF_TIMEOUT;
>
> The watchdog_init_timeout kerneldoc comment suggests that the old value
> should be the default timeout, i.e. that timeout should be set to
> PDC_WDT_DEF_TIMEOUT before calling watchdog_init_timeout, rather than
> whenever ret < 0.
>
> Indeed, if heartbeat is set to an invalid non-zero value,
> watchdog_init_timeout will still try and set timeout from DT, but also
> still returns -EINVAL regardless of whether that succeeds, and this
> would incorrectly override the timeout from DT with the hardcoded
> default.

Gah, right - will fix.

>>               dev_warn(&pdev->dev,
>> -                      "Initial timeout out of range! setting max timeout\n");
>> +                      "Initial timeout out of range! setting default timeout\n");
>
> It feels wrong for a presumably safe & normal situation (i.e. no default
> in DT, which arguably shouldn't contain policy anyway) to show a
> warning, but it can also show due to an invalid module parameter (or
> invalid DT property) which is most definitely justified.
>
> The caller can check (ret < 0 && heartbeat) to tell if heartbeat was
> invalid, but unfortunately it can't easily tell if the DT property is
> out of range rather than simply absent.

I suppose this is why most watchdog drivers ignore the return value of
watchdog_init_timeout().  Perhaps dev_dbg() or dev_info() and a better
error message would be more appropriate.

Thanks,
Andrew
