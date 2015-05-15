Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:54500 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422736AbbEOOGs (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 May 2015 10:06:48 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: fu.wei@linaro.org
Cc: Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, hanjun.guo@linaro.org, timur@codeaurora.org,
	ashwin.chaugule@linaro.org, linux@roeck-us.net,
	vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
	leo.duran@amd.com, corbet@lwn.net
Subject: Re: [PATCH 1/6] Documentation: add sbsa-gwdt.txt documentation
Date: Fri, 15 May 2015 16:06:29 +0200
Message-ID: <8715806.mTJfA5WAcP@wuerfel>
In-Reply-To: <1431688090-2145-2-git-send-email-fu.wei@linaro.org>
References: <=fu.wei@linaro.org> <1431688090-2145-1-git-send-email-fu.wei@linaro.org> <1431688090-2145-2-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Friday 15 May 2015 19:08:05 fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> The sbsa-gwdt.txt documentation in devicetree/bindings/watchdog is for
> introducing SBSA(Server Base System Architecture) Generic Watchdog
> device node info into FDT
> 
> Signed-off-by: Fu Wei <fu.wei@linaro.org>

Looks good, just one minor comment:

> +Optional properties
> +- timeout-sec : Watchdog pre-timeout and timeout values (in seconds).
> +	The first is timeout values, then pre-timeout.

Please update Documentation/watchdog/watchdog-kernel-api.txt as well, to
mention the second number in the timeout-sec property.

	Arnd

