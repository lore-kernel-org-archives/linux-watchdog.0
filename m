Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:36971 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756913AbbEVURv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 22 May 2015 16:17:51 -0400
Message-ID: <555F8EEC.7050007@codeaurora.org>
Date: Fri, 22 May 2015 15:17:48 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, linaro-acpi@lists.linaro.org
CC: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	corbet@lwn.net, jcm@redhat.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, wim@iguana.be,
	tekkamanninja@gmail.com, vgandhi@codeaurora.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [Linaro-acpi] [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog
 driver
References: <=fu.wei@linaro.org> <10437443.BChumWu5Uk@wuerfel> <555F5728.5060209@codeaurora.org> <3381585.xxhO00lRy6@wuerfel>
In-Reply-To: <3381585.xxhO00lRy6@wuerfel>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/22/2015 03:13 PM, Arnd Bergmann wrote:
>
> That might still be helpful to get coverage from things like the public
> coverity builds that always build x86 allmodconfig, but it's also a bit
> ugly.

Adding #ifdefs to allow COMPILE_TEST to work seems ironic to me.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
