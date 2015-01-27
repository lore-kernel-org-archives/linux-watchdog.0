Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:60721 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658AbbA0URG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 27 Jan 2015 15:17:06 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc: wim@iguana.be, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	paul@crapouillou.net
Subject: Re: [PATCH 1/2] dt: watchdog: Add DT binding documentation for jz47xx watchdog timer
Date: Tue, 27 Jan 2015 21:16:45 +0100
Message-ID: <11680810.808F8uDyN0@wuerfel>
In-Reply-To: <1422371490-44402-2-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1422371490-44402-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1422371490-44402-2-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tuesday 27 January 2015 15:11:29 Zubair Lutfullah Kakakhel wrote:
> +clocks: phandle to rtcclk
> +clock-names: must be "rtc"
> +
> +Example:
> +
> +watchdog: jz47xx-watchdog@0x10002000 {
> +       compatible = "ingenic,jz4780-watchdog";
> +       reg = <0x10002000 0x100>;
> +
> +       clocks = <&rtclk>;
> +       clock-names = "rtc";
> +};

Why is the name "rtc"? are you sure you are not confusing the output
name of the clock controller with the input of the watchdog device?

It's suspicious that both have similar names.

	Arnd
