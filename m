Return-path: <timo.kokkonen@offcode.fi>
Message-ID: <553DCC22.1090909@offcode.fi>
Date: Mon, 27 Apr 2015 08:41:54 +0300
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org,
 boris.brezillon@free-electrons.com, nicolas.ferre@atmel.com,
 alexandre.belloni@free-electrons.com, Wenyou.Yang@atmel.com
Subject: Re: [PATCHv7 1/8] watchdog: Extend kernel API to know about HW limitations
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi> <1429701102-22320-2-git-send-email-timo.kokkonen@offcode.fi> <20150424170848.GA2505@roeck-us.net>
In-Reply-To: <20150424170848.GA2505@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 24.04.2015 20:08, Guenter Roeck wrote:
> On Wed, Apr 22, 2015 at 02:11:35PM +0300, Timo Kokkonen wrote:
>> There is a great deal of diversity in the watchdog hardware found on
>> different devices. Differen hardware have different contstraints on
>> them, many of the constraints that are excessively difficult for the
>> user space to satisfy.
>>
>> One such constraint is the length of the timeout value, which in many
>> cases can be just a few seconds. Drivers are creating ad hoc solutions
>> with timers and workqueues to extend the timeout in order to give user
>> space more time between updates. Looking at the drivers it is clear
>> that this has resulted to a lot of duplicate code.
>>
>> Add an extension to the watchdog kernel API that allows the driver to
>> describe tis HW constraints to the watchdog code. A kernel worker in
>> the core is then used to extend the watchdog timeout on behalf of the
>> user space. This allows the drivers to be simplified as core takes
>> over the timer extending.
>>
>> Tested-by: Wenyou Yang <wenyou.yang@atmel.com>
>> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
>
> I started twice to review this series, and each time there is a new version
> before I can finish the review. Guess I'll wait until it settles down a bit
> before trying again :-(. Just a quick comment below.
>

Yeah, I didn't quite know how much time I had available to work with 
these patches, so I kept on sending fixed series out in a hope I get 
some feedback before making too big steps in any false direction.. And I 
ended up doing a  bit more than I thought at first. But I'm not going to 
make a new one until I have got enough feedback from this version. So 
please go ahead and review this version when you have time.

>> ---
>>   drivers/watchdog/watchdog_core.c | 101 +++++++++++++++++++++++++++++++++++++--
>>   drivers/watchdog/watchdog_dev.c  |  75 ++++++++++++++++++++++++++---
>>   include/linux/watchdog.h         |  23 +++++++++
>>   3 files changed, 189 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
>> index cec9b55..fd12489 100644
>> --- a/drivers/watchdog/watchdog_core.c
>> +++ b/drivers/watchdog/watchdog_core.c
>> @@ -99,6 +99,89 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
>>   EXPORT_SYMBOL_GPL(watchdog_init_timeout);
>>
>>   /**
>> + * watchdog_init_parms() - initialize generic watchdog parameters
>> + * @wdd: Watchdog device to operate
>> + * @dev: Device that stores the device tree properties
>> + *
>> + * Initialize the generic timeout parameters. The driver needs to set
>> + * hw_features bitmask from @wdd prior calling this function in order
>> + * to ensure the core knows how to handle the HW.
>> + *
>> + * A zero is returned on success and -EINVAL for failure.
>> + */
>> +int watchdog_init_params(struct watchdog_device *wdd, struct device *dev)
>> +{
>> +	int ret = 0;
>> +
>> +	ret = watchdog_init_timeout(wdd, wdd->timeout, dev);
>
> You are changing the semantics of watchdog_init_timeout here;
> for all practical purposes it no longer accepts the timeout passed
> as parameter, but expects the timeout to be configured in wdd->timeout
> instead. Please don't do that.

hmm.. Yes, this isn't quite right. What I thought it should be is that 
the driver initializes  the values with sane value (either from module 
parameter or some default) and then if that's not set (wdd->timeout is 
zero), watchdog_init_params() gets the value from device tree. If we 
still don't get any preference for the timeout, then use some reasonable 
default, such as 60 seconds. How's that?

Right now the module parameter basically gets ignored altogether, which 
is wrong.

-Timo
