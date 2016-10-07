Return-path: <frowand.list@gmail.com>
Subject: Re: [PATCH 00/10] Introduce Juniper PTXPMB CPLD driver
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Lee Jones <lee.jones@linaro.org>
References: <1475853451-22121-1-git-send-email-pantelis.antoniou@konsulko.com>
Cc: Rob Herring <robh+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>,
 Mark Rutland <mark.rutland@arm.com>, Wolfram Sang <wsa@the-dreams.de>,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>, Wim Van Sebroeck
 <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
 Peter Rosin <peda@axentia.se>, Debjit Ghosh <dghosh@juniper.net>,
 Georgi Vlaev <gvlaev@juniper.net>, Guenter Roeck <groeck@juniper.net>,
 JawaharBalaji Thirumalaisamy <jawaharb@juniper.net>,
 Rajat Jain <rajatjain@juniper.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-watchdog@vger.kernel.org
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <57F8324C.2040804@gmail.com>
Date: Fri, 7 Oct 2016 16:39:56 -0700
MIME-Version: 1.0
In-Reply-To: <1475853451-22121-1-git-send-email-pantelis.antoniou@konsulko.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 10/07/16 08:17, Pantelis Antoniou wrote:
> Add Juniper's PTXPMB FPGA CPLD driver. Those FPGAs
> are present in Juniper's PTX series of routers.
> 
> The MFD driver provices watchdog/i2c/gpio/mtd devices.
> 
> There are full device tree binding documents for the
> master mfd driver and for all slave drivers.
> 
> This patchset is against mainline as of today: v4.8-9431-g3477d16
> and is dependent on the "Juniper prerequisites" and
> "Juniper infrastructure" patchsets sent earlier.

Pointers to the patchsets please.

< snip >

-Frank
