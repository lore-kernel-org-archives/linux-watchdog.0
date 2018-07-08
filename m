Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38746 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754356AbeGHWni (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 8 Jul 2018 18:43:38 -0400
Subject: Re: [PATCH v2] dt-bindings: watchdog: renesas-wdt: Add support for
 the R8A77990 wdt
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
References: <20180706085508.30791-1-geert+renesas@glider.be>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d72596f7-e03f-26c4-742b-face854a00c9@roeck-us.net>
Date: Sun, 8 Jul 2018 15:43:35 -0700
MIME-Version: 1.0
In-Reply-To: <20180706085508.30791-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Geert,

On 07/06/2018 01:55 AM, Geert Uytterhoeven wrote:
> From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
> 
> Document support for the Watchdog Timer (WDT) Controller in the Renesas
> R-Car E3 (R8A77990) SoC.
> 
> No driver update is needed.
> 
> Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Rob Herring <robh@kernel.org>

The patch is queued in my tree, so there should be no need to resend it anymore.

Guenter

> ---
> v2:
>    - Add Reviewed-by, Acked-by.
> ---
>   Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> index f24d802b8056f6c6..5d47a262474cfe0e 100644
> --- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> @@ -16,6 +16,7 @@ Required properties:
>   	         - "renesas,r8a7796-wdt" (R-Car M3-W)
>   		 - "renesas,r8a77965-wdt" (R-Car M3-N)
>   	         - "renesas,r8a77970-wdt" (R-Car V3M)
> +	         - "renesas,r8a77990-wdt" (R-Car E3)
>   	         - "renesas,r8a77995-wdt" (R-Car D3)
>   	         - "renesas,r7s72100-wdt" (RZ/A1)
>   		The generic compatible string must be:
> 

