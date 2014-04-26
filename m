Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:56105 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbaDZPfP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 26 Apr 2014 11:35:15 -0400
Message-ID: <535BD22E.8070607@roeck-us.net>
Date: Sat, 26 Apr 2014 08:35:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Gabor Juhos <juhosg@openwrt.org>, Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: ath79_wdt: switch to clk_prepare/clk_disable
References: <1397640950-21859-1-git-send-email-juhosg@openwrt.org>
In-Reply-To: <1397640950-21859-1-git-send-email-juhosg@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/16/2014 02:35 AM, Gabor Juhos wrote:
> Replace clk_enable() and clk_disable() calls with
> clk_prepare_enable() and clk_disable_unprepare()
> to get ready for the migration to the common clock
> framework.
>
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


