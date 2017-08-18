Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:33278 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbdHRH7l (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 18 Aug 2017 03:59:41 -0400
Date: Fri, 18 Aug 2017 09:59:37 +0200
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: renesas-wdt: Add support for the
 r8a77995 wdt
Message-ID: <20170818075936.GE9175@verge.net.au>
References: <1502968465-7809-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502968465-7809-1-git-send-email-geert+renesas@glider.be>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Aug 17, 2017 at 01:14:25PM +0200, Geert Uytterhoeven wrote:
> Document support for the Watchdog Timer (WDT) Controller in the Renesas
> R-Car D3 (r8a77995) SoC.
> 
> No driver update is needed.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>
