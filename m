Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47403 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754744AbbHFJYK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 6 Aug 2015 05:24:10 -0400
Message-ID: <55C327B5.4050902@roeck-us.net>
Date: Thu, 06 Aug 2015 02:24:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Barry Song <21cnbao@gmail.com>, wim@iguana.be,
	linux-watchdog@vger.kernel.org
CC: workgroup.linux@csr.com, William Wang <William.Wang@csr.com>,
	Guo Zeng <guo.zeng@csr.com>, Barry Song <Baohua.Song@csr.com>
Subject: Re: [PATCH] watchdog : sirf: add support for CSR atlas7 SoC
References: <1438849919-27724-1-git-send-email-21cnbao@gmail.com>
In-Reply-To: <1438849919-27724-1-git-send-email-21cnbao@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/06/2015 01:31 AM, Barry Song wrote:
> From: William Wang <William.Wang@csr.com>
>
> This patch adds support for the new CSR atlas7 chips. prima2 and atlas7
> are similar in chip design, but the register layout and flows have some
> differences.
>
> This patch puts the differences including register layout and operations
> in dt private data, so that one driver can be compatible for two chips.
>
> Signed-off-by: William Wang <William.Wang@csr.com>
> Signed-off-by: Guo Zeng <guo.zeng@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

You are pretty much doubling the size of this driver (from 225 to 446 LOC).
I don't see the benefits of having a single driver, sorry. It just makes
it very difficult to maintain. Please make this a separate driver.

Thanks,
Guenter

