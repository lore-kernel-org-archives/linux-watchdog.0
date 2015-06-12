Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52767 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbbFLUyj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 12 Jun 2015 16:54:39 -0400
Message-ID: <557B470B.9030908@codeaurora.org>
Date: Fri, 12 Jun 2015 15:54:35 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com,
	linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
CC: tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, hanjun.guo@linaro.org,
	ashwin.chaugule@linaro.org, arnd@arndb.de, linux@roeck-us.net,
	vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
	leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com,
	catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net
Subject: Re: [PATCH non-pretimeout 3/7] ARM64: add SBSA Generic Watchdog device
 node in amd-seattle-soc.dtsi
References: <=fu.wei@linaro.org> <1433958452-23721-1-git-send-email-fu.wei@linaro.org> <1433958452-23721-4-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1433958452-23721-4-git-send-email-fu.wei@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/10/2015 12:47 PM, fu.wei@linaro.org wrote:
> +			reg = <0x0 0xe0bb0000 0 0x10000>,
> +				<0x0 0xe0bc0000 0 0x10000>;

I think the sizes are wrong.  They should be 0x1000 instead of 0x10000.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
