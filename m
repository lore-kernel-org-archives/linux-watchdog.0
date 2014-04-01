Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:55460 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbaDAAAV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 31 Mar 2014 20:00:21 -0400
Message-ID: <533A018E.60606@roeck-us.net>
Date: Mon, 31 Mar 2014 17:00:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Alexander Shiyan <shc_work@mail.ru>, linux-watchdog@vger.kernel.org
CC: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: shwdt: Remove unused platform_set_drvdata()
References: <1396088940-9224-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1396088940-9224-1-git-send-email-shc_work@mail.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/29/2014 03:29 AM, Alexander Shiyan wrote:
> This patch removes platform_set_drvdata() which is not used in
> the driver.
>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


