Return-path: <shubhrajyoti.datta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20160816163403.GB28201@roeck-us.net>
References: <1471342652-40005-1-git-send-email-shubhrajyoti.datta@xilinx.com> <20160816163403.GB28201@roeck-us.net>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Wed, 17 Aug 2016 11:42:59 +0530
Message-ID: <CAKfKVtHWJSWkj5k+aKtVfPbk8xm32vApz2kamQ2ziuaqsPxvjQ@mail.gmail.com>
Subject: Re: [PATCH] watchdog: cadence_wdt: Fix the suspend resume
To: Guenter Roeck <linux@roeck-us.net>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Aug 16, 2016 at 10:04 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Tue, Aug 16, 2016 at 03:47:32PM +0530, Shubhrajyoti Datta wrote:
>> Currently even if no users are there the suspend tries to
>> stop the watchdog and resume starts the watchdog.
>>
>> So after resume the watchdog starts and resets the board.
>> Fix the same by adding a check for users.
>>
>> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>> ---
>>  drivers/watchdog/cadence_wdt.c | 22 +++++++++++++++-------
>>  1 file changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
>> index 4dda902..b58343c 100644
>> --- a/drivers/watchdog/cadence_wdt.c
>> +++ b/drivers/watchdog/cadence_wdt.c
>> @@ -77,6 +77,7 @@ MODULE_PARM_DESC(nowayout,
>>  struct cdns_wdt {
>>       void __iomem            *regs;
>>       bool                    rst;
>> +     bool                    cdns_wdt_users;
>>       struct clk              *clk;
>>       u32                     prescaler;
>>       u32                     ctrl_clksel;
>> @@ -129,6 +130,7 @@ static int cdns_wdt_stop(struct watchdog_device *wdd)
>>       struct cdns_wdt *wdt = watchdog_get_drvdata(wdd);
>>
>>       spin_lock(&wdt->io_lock);
>> +     wdt->cdns_wdt_users = false;
>
> Why not use watchdog_active() ?
will fix in next version

>
> Guenter
>
