Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:63099 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbaEOEor (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 15 May 2014 00:44:47 -0400
Message-ID: <53744636.8080104@roeck-us.net>
Date: Wed, 14 May 2014 21:44:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Viresh Kumar <viresh.kumar@linaro.org>, wim@iguana.be
CC: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, arun.ramamurthy@broadcom.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] watchdog: sp805: Set watchdog_device->timeout from ->set_timeout()
References: <c78a7ad282aff9bd1b88c55c2590438e17ef95e1.1400127943.git.viresh.kumar@linaro.org>
In-Reply-To: <c78a7ad282aff9bd1b88c55c2590438e17ef95e1.1400127943.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/14/2014 09:31 PM, Viresh Kumar wrote:
> Implementation of ->set_timeout() is supposed to set 'timeout' field of 'struct
> watchdog_device' passed to it. sp805 was rather setting this in a local
> variable. Fix it.
>
> Cc: <stable@vger.kernel.org> # 2.6.36+
> Reported-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

