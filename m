Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36024 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbeI3Axf (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 29 Sep 2018 20:53:35 -0400
Date: Sat, 29 Sep 2018 11:24:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc: linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [v4,2/4] dt-bindings: watchdog: Document armada-37xx-wdt binding
Message-ID: <20180929182408.GA18680@roeck-us.net>
References: <20180924110654.7329-3-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180924110654.7329-3-marek.behun@nic.cz>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Sep 24, 2018 at 01:06:52PM +0200, Marek Behún wrote:
> This adds device tree binding documentation for the CPU watchdog found
> on Armada 37xx SOCs (EspressoBin, Turris Mox).
> 
> Signed-off-by: Marek Behún <marek.behun@nic.cz>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  .../bindings/watchdog/armada-37xx-wdt.txt          | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt b/Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt
> new file mode 100644
> index 000000000000..a8d00c31a1d8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt
> @@ -0,0 +1,23 @@
> +* Armada 37xx CPU Watchdog Timer Controller
> +
> +Required properties:
> +- compatible : must be "marvell,armada-3700-wdt"
> +- reg : base physical address of the controller and length of memory mapped
> +	region.
> +- clocks : the clock feeding the watchdog timer. See clock-bindings.txt
> +- marvell,system-controller : reference to syscon node for the CPU Miscellaneous
> +	Registers
> +
> +Example:
> +
> +	cpu_misc: system-controller@d000 {
> +		compatible = "marvell,armada-3700-cpu-misc", "syscon";
> +		reg = <0xd000 0x1000>;
> +	};
> +
> +	wdt: watchdog@8300 {
> +		compatible = "marvell,armada-3700-wdt";
> +		reg = <0x8300 0x40>;
> +		marvell,system-controller = <&cpu_misc>;
> +		clocks = <&xtalclk>;
> +	};
