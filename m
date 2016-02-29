Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38989 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754362AbcB2Pvc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Feb 2016 10:51:32 -0500
Subject: Re: [PATCH v8] watchdog: Add watchdog timer support for the
 WinSystems EBC-C384
To: William Breathitt Gray <vilhelm.gray@gmail.com>, wim@iguana.be
References: <20160229045446.GA11655@sophia>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56D46901.7090602@roeck-us.net>
Date: Mon, 29 Feb 2016 07:51:29 -0800
MIME-Version: 1.0
In-Reply-To: <20160229045446.GA11655@sophia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/28/2016 08:54 PM, William Breathitt Gray wrote:
> The WinSystems EBC-C384 has an onboard watchdog timer. The timeout range
> supported by the watchdog timer is 1 second to 255 minutes. Timeouts
> under 256 seconds have a 1 second granularity, while the rest have a 1
> minute granularity.
>
> This driver adds watchdog timer support for this onboard watchdog timer.
> The timeout may be configured via the timeout module parameter.
>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

