Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33734 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbaITP3T (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 20 Sep 2014 11:29:19 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XVMb9-001o5x-38
	for linux-watchdog@vger.kernel.org; Sat, 20 Sep 2014 15:29:19 +0000
Message-ID: <541D9D20.6080503@roeck-us.net>
Date: Sat, 20 Sep 2014 08:28:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Carlo Caione <carlo@caione.org>, wim@iguana.be,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	maxime.ripard@free-electrons.com, b.galvani@gmail.com,
	linux@arm.linux.org.uk, jerry.cao@amlogic.com,
	victor.wan@amlogic.com
Subject: Re: [PATCH v3 1/4] ARM: docs: add documentation binding for meson
 watchdog
References: <1411158989-8075-1-git-send-email-carlo@caione.org> <1411158989-8075-2-git-send-email-carlo@caione.org>
In-Reply-To: <1411158989-8075-2-git-send-email-carlo@caione.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/19/2014 01:36 PM, Carlo Caione wrote:
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
>   Documentation/devicetree/bindings/watchdog/meson6-wdt.txt | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/meson6-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
> new file mode 100644
> index 0000000..9200fc2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
> @@ -0,0 +1,13 @@
> +Meson SoCs Watchdog timer
> +
> +Required properties:
> +
> +- compatible : should be "amlogic,meson6-wdt"
> +- reg : Specifies base physical address and size of the registers.
> +

The 'amlogic' vendor prefix is undefined.
It will have to be added to Documentation/devicetree/bindings/vendor-prefixes.txt.

Guenter

