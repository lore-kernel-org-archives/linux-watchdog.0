Return-Path: <nsekhar@ti.com>
Return-path: <nsekhar@ti.com>
Subject: Re: [PATCH 0/2] ARM: davinici: move watchdog restart from mach to
 drivers
To: David Lechner <david@lechnology.com>, Wim Van Sebroeck <wim@iguana.be>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-watchdog@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>
References: <1513012869-7647-1-git-send-email-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <64409d2d-dae3-53ef-67a9-fc4e59d6c9be@ti.com>
Date: Tue, 19 Dec 2017 16:14:44 +0530
MIME-Version: 1.0
In-Reply-To: <1513012869-7647-1-git-send-email-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi David,

On Monday 11 December 2017 10:51 PM, David Lechner wrote:
> This series moves the watchdog restart code from arch/arm/mach-davinci
> to drivers/watchdog.
> 
> Tested working on LEGO MINDSTORMS EV3 (TI AM1808 processor).

The patches look good to me. I also tested them on keystone-k2hk-evm and
da850-lcdk board. Thanks for the much needed clean-up!

Hi Wim,

How do you want to handle this series? Patch 2/2 definitely needs to go
through my tree as it will clash with other code I am queuing.

I can either take 1/2 also through ARM-SoC with your ack (preferred) or
if you give me an immutable commit/tag over v4.15-rc1, I can merge that
to preserve bisect-ability.

Thanks,
Sekhar
