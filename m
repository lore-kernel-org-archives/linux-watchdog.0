Return-path: <vivien.didelot@savoirfairelinux.com>
Date: Mon, 22 Jun 2015 16:46:13 -0400 (EDT)
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog <linux-watchdog@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	kernel <kernel@savoirfairelinux.com>
Message-ID: <497353189.111212.1435005973106.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <20150622165938.GA1526@roeck-us.net>
References: <1434581940-15086-3-git-send-email-vivien.didelot@savoirfairelinux.com> <20150622165938.GA1526@roeck-us.net>
Subject: Re: [v2,3/3] watchdog: max63xx: add heartbeat to platform data
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

On Jun 22, 2015, at 12:59 PM, Guenter Roeck linux@roeck-us.net wrote:
> Hi Vivien,
> 
> On Wed, Jun 17, 2015 at 06:59:00PM -0400, Vivien Didelot wrote:
>> Actually, there is no way but the module parameter to set the desired
>> heartbeat. This patch allows a platform code to set it in the device
>> platform data. This is convenient for platforms and built-in drivers.
>> 
>> To do so, initialize heartbeat to zero to allow the module parameter to
>> take precedence over the platform setting. If not set, it will still
>> default to DEFAULT_HEARTBEAT.
> 
> I think that warrants a bit of discussion. Is the chip used on an
> x86 system (no devicetree), and is there reason to believe that the
> default watchdog timeout is not good enough until the watchdog application
> starts and can configure it to a different value ?

Indeed, I am using a MAX6373 device on an embedded Atom platform. The
default 60s heartbeat is not valid for this chip. I need the setting
with 10s heartbeat and 60s delay.

> This is also a bit more complicated since gpio pin 0 can be a valid gpio
> pin number, so you'd have to explicitly state "don't use gpio" in the
> platform data.

Indeed. Also, you may have a gpio pin 0 and don't want to use it. I'd
prefer to avoid any additional boolean if possible. Having at least one
positive integer seems safe. Would this be better?

    /* GPIO or memory mapped? */
    if (platform_get_resource(pdev, IORESOURCE_MEM, 0))
            err = max63xx_mmap_init(pdev, wdt);
    else if (wdt->pdata && (wdt->pdata->wdi || wdt->pdata->set0 ||
                            wdt->pdata->set1 || wdt->pdata->set2))
            err = max63xx_gpio_init(pdev, wdt);
    else
            err = -EINVAL;
    if (err)
            return err;

Thanks,
-v
