Return-path: <moritz.fischer.private@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5f8fac22-4037-9983-436a-da8ff87d4b17@roeck-us.net>
References: <1493071512-5718-1-git-send-email-mdf@kernel.org> <5f8fac22-4037-9983-436a-da8ff87d4b17@roeck-us.net>
From: Moritz Fischer <moritz.fischer.private@gmail.com>
Date: Tue, 25 Apr 2017 07:55:28 -0700
Message-ID: <CAJYdmeP+XEBPpUECO1rWpRDs-RVihc_va970jtv6iau3OuWMWA@mail.gmail.com>
Subject: Re: [PATCH 0/2] DS1374 Watchdog fixes
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Moritz Fischer <moritz.fischer@ettus.com>,
	linux-watchdog@vger.kernel.org, wim@iguana.be, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, rtc-linux@googlegroups.com,
	alex.williams@ni.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

On Mon, Apr 24, 2017 at 10:03 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 04/24/2017 03:05 PM, Moritz Fischer wrote:

>> I'm very unhappy with the CONFIG_DRV_RTC_DS1374_WDT way of enabling
>> the watchdog behavior and currently I'm investigating how to make
>> that work via DT.
>>
>> Watchdog maintainers, do you have an idea on how to do that in a
>> non breaking fashion?
>>
>
> Depends on what you mean with "non breaking". Just using the normal mfd
> mechanisms, ie define an mfd cell for each client driver, should work.
> Do you see any problems with that ? Either case, that doesn't seem
> to be a watchdog driver problem, or am I missing something ?

Well so currently watchdog behavior is selected (out of the two options alarm,
or watchdog) by enabling the configuration option mentioned above.
If I change this over to use a dt-based approach like dallas,ds1374-mode = <2>;
to select the behavior in the mfd for example, won't that break people that
relied on the old behavior? If everyone involved is ok with that, I'm happy
to just add it to the binding.

> I don't really see the point of doing that if you plan to move the watchdog
> part of the driver into the watchdog directory. We for sure won't accept a
> watchdog driver that does not use the watchdog infrastructure.

The idea was to fix what's broken currently (this patchset) and then refactor.
But if you prefer I can do all in one go instead.

>
> Regarding
> +       /* WHY? */
> +       ds1374->wdd.timeout = t;
>
> Assuming you mean why the driver has to set the timeout value - not every
> watchdog hardware supports timeouts in multiples of 1 second. The driver
> is expected to set the value to the real timeout, not to the timeout asked
> for by the infrastructure.

Yeah that branch is work in progress and needs cleanup. Leftover from testing,
before I had understood why. Branch needs cleanup. It also doesn't really use
regmap_update_bits etc.

Thanks for the explanation,

Moritz
