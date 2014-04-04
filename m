Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:53603 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429AbaDDSCI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 4 Apr 2014 14:02:08 -0400
Message-ID: <533EF39D.6090907@roeck-us.net>
Date: Fri, 04 Apr 2014 11:02:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?RW1pbGlvIEzDs3Bleg==?= <emilio@elopez.com.ar>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	wim@iguana.be, carlo.caione@gmail.com
CC: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] watchdog: sunxi: Fix compilation with C=2
References: <1396632265-16124-1-git-send-email-emilio@elopez.com.ar>
In-Reply-To: <1396632265-16124-1-git-send-email-emilio@elopez.com.ar>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/04/2014 10:24 AM, Emilio López wrote:
> When compiling sunxi_defconfig while using C=2, the following error
> causes the compilation to fail:
>
>      drivers/watchdog/sunxi_wdt.c:60:15: error: constant 0b0001 is not a valid number
>
> Fix it by using hex notation instead of the non-standard binary one
>
> Signed-off-by: Emilio López <emilio@elopez.com.ar>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

