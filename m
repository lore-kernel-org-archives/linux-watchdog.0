Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53644 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933469AbbFCSQq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 3 Jun 2015 14:16:46 -0400
Message-ID: <556F4489.6030206@codeaurora.org>
Date: Wed, 03 Jun 2015 13:16:41 -0500
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
Subject: Re: [PATCH v4 5/7] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org> <1433217907-928-1-git-send-email-fu.wei@linaro.org> <1433217907-928-6-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1433217907-928-6-git-send-email-fu.wei@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/01/2015 11:05 PM, fu.wei@linaro.org wrote:
> +	if (wdd->pretimeout)
> +		/* The pretimeout is valid, go panic */
> +		panic("SBSA Watchdog pre-timeout");

The problem with this is that WS1 will still occur.  So a few seconds 
after the panic() call, the hardware will reset.  There won't be any 
time to debug or log anything.

> +		/* We don't use pretimeout, trigger WS1 now*/
> +		sbsa_gwdt_set_wcv(wdd, 0);

Are you sure this will work?   This will set WCV to 0, which means it 
the WS1 reset won't happen until the timestamp counter wraps around to 
0.  That could be a very long time from now.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
