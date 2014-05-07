Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36186 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbaEGVd2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 May 2014 17:33:28 -0400
Date: Wed, 7 May 2014 14:33:18 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, wim@iguana.be, dbaryshkov@gmail.com,
	dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 1/6] wdt: sunxi: Move restart code to the watchdog
 driver
Message-ID: <20140507213318.GA2105@roeck-us.net>
References: <1399430664-29091-1-git-send-email-maxime.ripard@free-electrons.com>
 <1399430664-29091-2-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1399430664-29091-2-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, May 06, 2014 at 09:44:19PM -0500, Maxime Ripard wrote:
> Most of the watchdog code is duplicated between the machine restart code and
> the watchdog driver. Add the restart hook to the watchdog driver, to be able to
> remove it from the machine code eventually.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
