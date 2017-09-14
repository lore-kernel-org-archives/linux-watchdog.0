Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1505389454.10100.5.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] watchdog: dw_wdt: add stop watchdog operation
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
        Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Date: Thu, 14 Sep 2017 13:44:14 +0200
In-Reply-To: <20170914113013.19157-1-o.rempel@pengutronix.de>
References: <20170914113013.19157-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, 2017-09-14 at 13:30 +0200, Oleksij Rempel wrote:
> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 
> The only way of stopping the watchdog is by resetting it.
> Add the watchdog op for stopping the device and reset if
> a reset line is provided.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-watchdog@vger.kernel.org

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
