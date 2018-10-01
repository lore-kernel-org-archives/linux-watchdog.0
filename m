Return-Path: <giel@mortis.eu>
Return-path: <giel@mortis.eu>
Subject: Re: Default behavior of watchdog drivers
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>,
 linux-watchdog@vger.kernel.org, Martin Wilck <mwilck@suse.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Giel van Schijndel <me@mortis.eu>, "Steven J. Hill"
 <Steven.Hill@cavium.com>
References: <20180927143855.6f8cc48e@endymion>
 <253a3ffa-2965-cb74-addb-ebcda2f6ab55@roeck-us.net>
From: Giel van Schijndel <giel@mortis.eu>
Message-ID: <738b74f7-5fcd-f50c-8f38-653fb7f573f7@mortis.eu>
Date: Mon, 1 Oct 2018 13:36:14 +0200
MIME-Version: 1.0
In-Reply-To: <253a3ffa-2965-cb74-addb-ebcda2f6ab55@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-ID: <linux-watchdog@vger.kernel.org>

Hi Jean, Guenter,

On 27-09-18 15:08, Guenter Roeck wrote:
> Hi Jean,
>
> On 09/27/2018 05:38 AM, Jean Delvare wrote:
>> It seems that various watchdog drivers behave differently if the
>> watchdog timer is already enabled when the driver is loaded:
>>
>> ... snip ...
>>
>> Can we please settle on a default behavior (either all drivers reset
>> the timer a load time, or none do it) and have all watchdog drivers
>> stick to that?
>>
>
> ... snip ...
>
>> If an option to get the opposite behavior is deemed useful, can we
>> settle on a standard name for it? Or even implement it at the
>> watchdog_core level, so that each driver doesn't need to implement it
>> separately?
>>
>> While looking into this, I found a few other strange module parameters:
>>
>> * f71808e_wdt has "start_withtimeout", which starts the timer even if
>>    nobody opens the watchdog device node. Giel, do we really need this?
>
> We had requests for a common mechanism to do that, ie some kind of boot
> timeout. Idea would be to reboot the system if the watchdog device has
> not been opened after a set period of time. Maybe that is the idea here.

The purpose of this parameter is to reduce the time window that we need to
trust software to behave correctly. Withthis parameter we don't need to
trust user land at all in order to still be protected by the watchdog.

I'm not sure currently because I no longer work for the company that relied
on this. But, from memory, the init system that was being used at the time
was, occassionaly, prone to hang due to some services hanging at startup,
preventing watchdog startup. These were systems deployed at distant
locations
in the field with, unreliable, GPRS connections for remote maintenance. This
watchdog parameter completely eliminated the need for field trips for
anything
less than hardware failure in the time that I was there (about a year).

-- 
Met vriendelijke groet,
With kind regards,
Giel van Schijndel
