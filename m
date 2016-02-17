Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45438 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933619AbcBQDnC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 16 Feb 2016 22:43:02 -0500
Subject: Re: [PATCH v13 4/4] Watchdog: introduce ARM SBSA watchdog driver
To: fu.wei@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, wim@iguana.be, corbet@lwn.net,
	catalin.marinas@arm.com, will.deacon@arm.com,
	Suravee.Suthikulpanit@amd.com
References: <1455642530-19103-1-git-send-email-fu.wei@linaro.org>
 <1455642530-19103-5-git-send-email-fu.wei@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
	rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
	timur@codeaurora.org, dyoung@redhat.com, panand@redhat.com,
	graeme.gregory@linaro.org, al.stone@linaro.org,
	hanjun.guo@linaro.org, jcm@redhat.com, arnd@arndb.de,
	leo.duran@amd.com, sudeep.holla@arm.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56C3EC40.6080500@roeck-us.net>
Date: Tue, 16 Feb 2016 19:42:56 -0800
MIME-Version: 1.0
In-Reply-To: <1455642530-19103-5-git-send-email-fu.wei@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/16/2016 09:08 AM, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> According to Server Base System Architecture (SBSA) specification,
> the SBSA Generic Watchdog has two stage timeouts: the first signal (WS0)
> is for alerting the system by interrupt, the second one (WS1) is a real
> hardware reset.
> More details about the hardware specification of this device:
> ARM DEN0029B - Server Base System Architecture (SBSA)
>
> This driver can operate ARM SBSA Generic Watchdog as a single stage watchdog
> or a two stages watchdog, it's set up by the module parameter "action".
> In the single stage mode, when the timeout is reached, your system
> will be reset by WS1. The first signal (WS0) is ignored.
> In the two stages mode, when the timeout is reached, the first signal (WS0)
> will trigger panic. If the system is getting into trouble and cannot be reset
> by panic or restart properly by the kdump kernel(if supported), then the
> second stage (as long as the first stage) will be reached, system will be
> reset by WS1. This function can help administrator to backup the system
> context info by panic console output or kdump.
>
> This driver bases on linux kernel watchdog framework, so it can get
> timeout from module parameter and FDT at the driver init stage.
>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> Reviewed-by: Graeme Gregory <graeme.gregory@linaro.org>
> Tested-by: Pratyush Anand <panand@redhat.com>
> Acked-by: Timur Tabi <timur@codeaurora.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Tested-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

