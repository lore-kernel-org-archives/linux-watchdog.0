Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33018 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbdEOVo5 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 15 May 2017 17:44:57 -0400
Date: Mon, 15 May 2017 16:44:55 -0500
From: Rob Herring <robh@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Dinh Nguyen <dinguyen@opensource.altera.com>,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 1/3] watchdog: bindings: dw_wdt: add reset lines
Message-ID: <20170515214455.f7jorcqou4oyvnkq@rob-hp-laptop>
References: <cover.e174fd0fa926fadf54e0f76e07f238bed3e162fc.1494595189.git-series.s.trumtrar@pengutronix.de>
 <44e4e733055cfa2ed79091542c7bb17aa24afca9.1494595189.git-series.s.trumtrar@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44e4e733055cfa2ed79091542c7bb17aa24afca9.1494595189.git-series.s.trumtrar@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, May 12, 2017 at 03:34:35PM +0200, Steffen Trumtrar wrote:
> Document the reset lines holding the watchdog core in reset.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-watchdog@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/watchdog/dw_wdt.txt | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
