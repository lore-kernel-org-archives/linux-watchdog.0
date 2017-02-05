Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751832AbdBEEyr (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 4 Feb 2017 23:54:47 -0500
Date: Sun, 5 Feb 2017 12:54:30 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Baoyou Xie <baoyou.xie@linaro.org>, Jun Nie <jun.nie@linaro.org>,
        wim@iguana.be, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "xie.baoyou" <xie.baoyou@zte.com.cn>, chen.chaokai@zte.com.cn,
        wang.qiang01@zte.com.cn
Subject: Re: [PATCH v9 2/3] MAINTAINERS: add zx2967 watchdog controller
 driver to ARM ZTE architecture
Message-ID: <20170205045429.GE3407@dragon>
References: <1486172055-13162-1-git-send-email-baoyou.xie@linaro.org>
 <1486172055-13162-2-git-send-email-baoyou.xie@linaro.org>
 <4cba1be6-ee85-7371-ea02-1bf8e7eb628e@roeck-us.net>
 <CA+DQWkyOZPQORy-rVSqGY8Ht9xWttYt6Csp6pvShGG4OVA_2YQ@mail.gmail.com>
 <20170205034504.GD3407@dragon>
 <e8573429-8082-abc2-be23-4605172cedf1@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8573429-8082-abc2-be23-4605172cedf1@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

On Sat, Feb 04, 2017 at 08:29:27PM -0800, Guenter Roeck wrote:
> Yes. One of the problems is that the patch doesn't apply to my tree
> (which is based on v4.10-rc3), and it doesn't have a common anchestor,
> meaning it is most likely not based on mainline. I would prefer to avoid
> conflicts with the arm tree if possible.

Understood.  You only need to handle patch #1 and #3, and we will sort
out MAINTAINERS update separately.  Thanks.

Shawn
