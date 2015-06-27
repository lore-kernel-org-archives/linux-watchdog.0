Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38945 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbbF0QRm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 27 Jun 2015 12:17:42 -0400
Message-ID: <558ECCA2.2070204@roeck-us.net>
Date: Sat, 27 Jun 2015 09:17:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
CC: linux-watchdog <linux-watchdog@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	kernel <kernel@savoirfairelinux.com>
Subject: Re: [v2,2/3] watchdog: max63xx: add GPIO support
References: <1434581940-15086-2-git-send-email-vivien.didelot@savoirfairelinux.com> <20150622165327.GA1189@roeck-us.net> <1645175105.110998.1435005823701.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <1645175105.110998.1435005823701.JavaMail.zimbra@savoirfairelinux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/22/2015 01:43 PM, Vivien Didelot wrote:
> Hi Guenter,
>
> On Jun 22, 2015, at 12:53 PM, Guenter Roeck linux@roeck-us.net wrote:
>> On Wed, Jun 17, 2015 at 06:58:59PM -0400, Vivien Didelot wrote:
>>> Introduce a new struct max63xx_platform_data to support MAX63xx watchdog
>>> chips connected via GPIO. A platform code can fill this structure with
>>> GPIO numbers for WDI and WDSET pins to enable GPIO support in the code.
>>>
>>> The driver takes care of requesting and releasing the GPIOs.
>>>
>>> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
>>
>> would it be possible to use gpiod functions ?
>
> It might be, but I never played with it yet though. I'm using integer-based
> GPIOs from a TCA6424 on an x86 platform (no Device Tree). Is it ok to keep
> max63xx_gpio_{ping,set} for legacy GPIOs, and let someone add
> max63xx_gpiod_{ping,set} if there is a need?
>

Hi Vivien,

That would pretty much defeat the purpose. The gpiod API is supposed
to replace the gpio API, not to augment it. Having both at the same time
does not really make sense.

There is a mapping from integer based pins to name based pins; check out
gpiod_add_lookup_table(). Essentially platform initialization code
(in your case probably the code which instantiates the tca6424) would
set up a pin lookup table, and then you would request pins using
a name instead of a number. That would also solve the "is the pin
valid" problem in patch 3/3 since you would have a string to identify
the gpio pin.

Thanks,
Guenter

