Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34543 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbcEZKJE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 26 May 2016 06:09:04 -0400
Date: Thu, 26 May 2016 12:09:01 +0200
From: Carlo Caione <carlo@caione.org>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
	linux-amlogic@lists.infradead.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 2/3] dt-bindings: watchdog: Add Meson GXBB Watchdog
 bindings
Message-ID: <20160526100901.GC14703@mephisto>
References: <1464249112-13658-1-git-send-email-narmstrong@baylibre.com>
 <1464249112-13658-3-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1464249112-13658-3-git-send-email-narmstrong@baylibre.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 26/05/16 09:51, Neil Armstrong wrote:
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/watchdog/meson-gxbb-wdt.txt         | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt
> new file mode 100644
> index 0000000..d06c0a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt
> @@ -0,0 +1,13 @@
> +Meson GXBB SoCs Watchdog timer
> +
> +Required properties:
> +
> +- compatible : should be "amlogic,meson-gxbb-wdt"
> +- reg : Specifies base physical address and size of the registers.

'clocks' is also required IIRC.

Thanks,

-- 
Carlo Caione
