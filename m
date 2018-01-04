Return-Path: <zboszor@pr.hu>
Return-path: <zboszor@pr.hu>
Subject: Re: [PATCH 00/12] watchdog: sp5100_tco: Various improvements
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1514149448-20214-1-git-send-email-linux@roeck-us.net>
From: Boszormenyi Zoltan <zboszor@pr.hu>
Message-ID: <d6a9a214-ae16-d4ac-3654-c95832b91fcd@pr.hu>
Date: Thu, 4 Jan 2018 12:41:32 +0100
MIME-Version: 1.0
In-Reply-To: <1514149448-20214-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Thanks for taking up this work.

I will test it and the other small series for i2c-piix4 as soon as possible.

2017-12-24 22:03 keltezéssel, Guenter Roeck írta:
> The sp5100_tco watchdog driver does not really support recent AMD CPUs,
> even though it claims to do so. On top of that, it doesn't use the
> watchdog subsystem, and various other problems have crept in. Let's
> clean it up for good.
> 
> The code was tested on AMD Ryzen 1700 with motherboards from MSI and
> Gigabyte. Tests on older hardware would be useful to make sure that
> nothing broke.
> 
> ----------------------------------------------------------------
> Guenter Roeck (12):
>        watchdog: sp5100_tco: Always use SP5100_IO_PM_{INDEX_REG,DATA_REG}
>        watchdog: sp5100_tco: Fix watchdog disable bit
>        watchdog: sp5100_tco: Use request_muxed_region where possible
>        watchdog: sp5100_tco: Use standard error codes
>        watchdog: sp5100_tco: Clean up sp5100_tco_setupdevice
>        watchdog: sp5100_tco: Match PCI device early
>        watchdog: sp5100_tco: Use dev_ print functions where possible
>        watchdog: sp5100_tco: Clean up function and variable names
>        watchdog: sp5100_tco: Convert to use watchdog subsystem
>        watchdog: sp5100_tco: Use bit operations
>        watchdog: sp5100-tco: Abort if watchdog is disabled by hardware
>        watchdog: sp5100_tco: Add support for recent FCH versions
> 
>   drivers/watchdog/sp5100_tco.c | 710 ++++++++++++++++++------------------------
>   drivers/watchdog/sp5100_tco.h |  57 ++--
>   2 files changed, 344 insertions(+), 423 deletions(-)
> 
