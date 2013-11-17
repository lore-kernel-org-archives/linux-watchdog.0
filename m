Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:51487 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414Ab3KQC2o (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 16 Nov 2013 21:28:44 -0500
Message-ID: <528829DB.7020003@roeck-us.net>
Date: Sat, 16 Nov 2013 18:28:43 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: "ivan.khoronzhuk" <ivan.khoronzhuk@ti.com>,
	Santosh Shilimkar <santosh.shilimkar@ti.com>, wim@iguana.be,
	nsekhar@ti.com, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org
CC: grant.likely@linaro.org, rob.herring@calxeda.com,
	pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org,
	galak@kernel.crashing.org, ijc+devicetree@hellion.org.uk,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: Fwd: [PATCH 7/8] watchdog: davinci: add "clocks" property
References: <1383680783-12114-8-git-send-email-ivan.khoronzhuk@ti.com> <527A28E8.4010204@ti.com>
In-Reply-To: <527A28E8.4010204@ti.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/06/2013 03:32 AM, ivan.khoronzhuk wrote:
> The Keystone arch is using clocks in DT and source clock for watchdog
> has to be specified, so add this to binding.
>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
>   .../devicetree/bindings/watchdog/davinci-wdt.txt   |    5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt b/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
> index fddced9..4db4d0e 100644
> --- a/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
> @@ -7,6 +7,10 @@ Required properties:
>
>   - reg : Should contain WDT registers location and length
>
> +- clocks: phandle reference to the controller clock.
> +	  Required only for Keystone arch.
> +	  See clock-bindings.txt
> +

Yet another form of formatting. Also, wonder if it makes sense to merge this with the patch adding keystone support.

>   Optional properties:
>
>   - timeout-sec:		Contains the watchdog timeout in seconds
> @@ -21,4 +25,5 @@ wdt: wdt@2320000 {
>   	compatible = "ti,davinci-wdt";
>   	reg = <0x02320000 0x80>;
>   	timeout-sec = <30>;
> +	clocks = <&clkwdtimer0>;
>   };
>

