Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:54581 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001Ab3LRRUt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 Dec 2013 12:20:49 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jonas Jensen <jonas.jensen@gmail.com>
Subject: Re: [PATCH] watchdog: mach-moxart: add restart handler
Date: Wed, 18 Dec 2013 18:20:39 +0100
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	arm@kernel.org, linux@roeck-us.net
References: <1387379883-16525-1-git-send-email-jonas.jensen@gmail.com>
In-Reply-To: <1387379883-16525-1-git-send-email-jonas.jensen@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201312181820.39639.arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wednesday 18 December 2013, Jonas Jensen wrote:
> mach-moxart lacks a separate register for reset; as a workaround,
> add a function that can be hooked to arm_pm_restart.
> 
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
