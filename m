Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:58906 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbbEUIqI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 May 2015 04:46:08 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: fu.wei@linaro.org
Cc: Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, hanjun.guo@linaro.org, timur@codeaurora.org,
	ashwin.chaugule@linaro.org, linux@roeck-us.net,
	vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
	leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com
Subject: Re: [PATCH v2 3/7] ARM64: add SBSA Generic Watchdog device node in foundation-v8.dts
Date: Thu, 21 May 2015 10:45:50 +0200
Message-ID: <10436688.ghBfa0dkUg@wuerfel>
In-Reply-To: <1432197156-16947-4-git-send-email-fu.wei@linaro.org>
References: <=fu.wei@linaro.org> <1432197156-16947-1-git-send-email-fu.wei@linaro.org> <1432197156-16947-4-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thursday 21 May 2015 16:32:32 fu.wei@linaro.org wrote:
> +       watchdog0: watchdog@2a450000 {
> +               compatible = "arm,sbsa-gwdt";
> +               reg = <0x0 0x2a450000 0 0x10000>,
> +                       <0x0 0x2a440000 0 0x10000>;
> +               reg-names = "refresh",
> +                       "control";
> +               interrupts = <0 27 4>;
> +               interrupt-names = "ws0";
> +               timeout-sec = <10 5>;
> +       };
>  };
> 

just one tiny comment: you can drop the 'watchdog0:' label here, there
is normally no reason to assign a label to a watchdog device, especially
if it's in a .dts file rather than a .dtsi.

The same is true for the example in the binding documentation.

	Arnd
