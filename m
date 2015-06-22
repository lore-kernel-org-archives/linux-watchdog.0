Return-path: <vivien.didelot@savoirfairelinux.com>
Date: Mon, 22 Jun 2015 16:43:43 -0400 (EDT)
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog <linux-watchdog@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	kernel <kernel@savoirfairelinux.com>
Message-ID: <1645175105.110998.1435005823701.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <20150622165327.GA1189@roeck-us.net>
References: <1434581940-15086-2-git-send-email-vivien.didelot@savoirfairelinux.com> <20150622165327.GA1189@roeck-us.net>
Subject: Re: [v2,2/3] watchdog: max63xx: add GPIO support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

On Jun 22, 2015, at 12:53 PM, Guenter Roeck linux@roeck-us.net wrote:
> On Wed, Jun 17, 2015 at 06:58:59PM -0400, Vivien Didelot wrote:
>> Introduce a new struct max63xx_platform_data to support MAX63xx watchdog
>> chips connected via GPIO. A platform code can fill this structure with
>> GPIO numbers for WDI and WDSET pins to enable GPIO support in the code.
>> 
>> The driver takes care of requesting and releasing the GPIOs.
>> 
>> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> 
> would it be possible to use gpiod functions ?

It might be, but I never played with it yet though. I'm using integer-based
GPIOs from a TCA6424 on an x86 platform (no Device Tree). Is it ok to keep
max63xx_gpio_{ping,set} for legacy GPIOs, and let someone add
max63xx_gpiod_{ping,set} if there is a need?

Thanks,
-v
