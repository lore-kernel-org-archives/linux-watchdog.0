Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:36834 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932189AbbEWTq6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 23 May 2015 15:46:58 -0400
Message-ID: <5560D92D.2070306@codeaurora.org>
Date: Sat, 23 May 2015 14:46:53 -0500
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
	leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com
Subject: Re: [PATCH v2 7/7] ACPI: import watchdog info of GTDT into
 platform device
References: <=fu.wei@linaro.org> <1432197156-16947-1-git-send-email-fu.wei@linaro.org> <1432197156-16947-8-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1432197156-16947-8-git-send-email-fu.wei@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

fu.wei@linaro.org wrote:
> From: Fu Wei<fu.wei@linaro.org>
>
> Parse SBSA Generic Watchdog Structure in GTDT table of ACPI,
> and create a platform device with that information.
> This platform device can be used by the ARM SBSA Generic
> Watchdog driver.
>
> Signed-off-by: Fu Wei<fu.wei@linaro.org>

Tested-by: Timur Tabi <timur@codeaurora.org>

I have modified my watchdog driver to use this patch.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
