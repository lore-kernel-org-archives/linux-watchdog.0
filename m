Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38886 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756288AbcEEXiF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 5 May 2016 19:38:05 -0400
Subject: Re: [PATCH RFC] Watchdog: sbsa_gwdt: Enhance timeout range
To: Guenter Roeck <linux@roeck-us.net>,
	Pratyush Anand <panand@redhat.com>
Cc: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com, wim@iguana.be,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
References: <5728A7C3.4010001@roeck-us.net>
 <20160503143856.GE13045@dhcppc6.redhat.com> <5728BEC4.6050603@codeaurora.org>
 <20160503155141.GF13045@dhcppc6.redhat.com>
 <20160503171602.GA2518@roeck-us.net>
 <20160504141449.GG13045@dhcppc6.redhat.com> <572A0577.1070000@codeaurora.org>
 <20160504155932.GH13045@dhcppc6.redhat.com> <572A2099.4070901@codeaurora.org>
 <20160505164300.GA16914@roeck-us.net>
 <20160505182031.GB12434@dhcppc6.redhat.com> <572B8F52.2000709@codeaurora.org>
 <572BD8E3.4070707@roeck-us.net>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <572BD959.3090507@codeaurora.org>
Date: Thu, 5 May 2016 18:38:01 -0500
MIME-Version: 1.0
In-Reply-To: <572BD8E3.4070707@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Guenter Roeck wrote:
> A 32-bit counter is absolutely fine. Letting it run with a 400MHz clock
> (or was it 200 MHz ?) is the problem. A resolution of 2.5ns for a watchdog
> timer does not really make any sense.

The 10 second limit is based on a 20MHz clock.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.
