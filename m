Return-path: <shubhrajyoti.datta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <9764548b-3586-0e28-b535-ec5d983ad8c5@roeck-us.net>
References: <1471945741-5021-1-git-send-email-shubhrajyoti.datta@xilinx.com> <9764548b-3586-0e28-b535-ec5d983ad8c5@roeck-us.net>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Wed, 7 Sep 2016 11:27:20 +0530
Message-ID: <CAKfKVtFWRZx7Vn+hNffb-12-eMOKsoPex3XDi9Py=DZs+7t1PA@mail.gmail.com>
Subject: Re: [PATCHv2] watchdog: cadence_wdt: Fix the suspend resume
To: Guenter Roeck <linux@roeck-us.net>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Aug 23, 2016 at 6:15 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 08/23/2016 02:49 AM, Shubhrajyoti Datta wrote:
>>
>> Currently even if no users are there the suspend tries to
>> stop the watchdog and resume starts it.
>>
>> so after resume the watchdog starts and resets the board.
>> Fix the same by adding a check for users.
>>
>> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
If there are no further comments then can this be merged

>
>
>> ---
