Return-Path: <robherring2@gmail.com>
Return-path: <robherring2@gmail.com>
Date: Thu, 27 Sep 2018 13:42:26 -0500
From: Rob Herring <robh@kernel.org>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc: linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
	Guenter Roeck <linux@roeck-us.net>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: watchdog: Document armada-37xx-wdt
 binding
Message-ID: <20180927184226.GA25910@bogus>
References: <20180924110654.7329-1-marek.behun@nic.cz>
 <20180924110654.7329-3-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180924110654.7329-3-marek.behun@nic.cz>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, 24 Sep 2018 13:06:52 +0200, =?UTF-8?q?Marek=20Beh=C3=BAn?= wrote:
> This adds device tree binding documentation for the CPU watchdog found
> on Armada 37xx SOCs (EspressoBin, Turris Mox).
> 
> Signed-off-by: Marek Behún <marek.behun@nic.cz>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  .../bindings/watchdog/armada-37xx-wdt.txt          | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
