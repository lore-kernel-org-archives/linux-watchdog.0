Return-path: <timur@codeaurora.org>
Subject: Re: [PATCH RFC] Watchdog: sbsa_gwdt: Enhance timeout range
To: Pratyush Anand <panand@redhat.com>, Guenter Roeck <linux@roeck-us.net>
Cc: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com, wim@iguana.be,
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>
References: <20da73bb9bdf27993514c1da80fead13dc92932d.1462262900.git.panand@redhat.com>
 <5728A7C3.4010001@roeck-us.net> <20160503143856.GE13045@dhcppc6.redhat.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <5728BEC4.6050603@codeaurora.org>
Date: Tue, 3 May 2016 10:07:48 -0500
MIME-Version: 1.0
In-Reply-To: <20160503143856.GE13045@dhcppc6.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Pratyush Anand wrote:
> In fact after supporting max_hw_heartbeat_ms, there should be no change for
> action=0 functionally. However, we would still need some changes for action=1.

IMHO, action=1 is more of a debugging option, and not something that 
would be used normally.  I would need to see some evidence that real 
users want to have action=1 and a longer timeout.

I've never been a fan of the action=1 option, and I'm certainly not keen 
any patches that make action=1 more complicated than it already is.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.
