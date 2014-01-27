Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f194.google.com ([209.85.192.194]:39222 "EHLO
	mail-pd0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138AbaA0Qdd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jan 2014 11:33:33 -0500
Received: by mail-pd0-f194.google.com with SMTP id v10so3710542pde.1
        for <linux-watchdog@vger.kernel.org>; Mon, 27 Jan 2014 08:33:33 -0800 (PST)
Date: Mon, 27 Jan 2014 08:33:32 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: linux-watchdog@vger.kernel.org, vasily.isaenko@oracle.com
Subject: Re: [PATCH] watchdog: w83697hf_wdt: return ENODEV if no device was
 found
Message-ID: <20140127163332.GA29882@roeck-us.net>
References: <1390806273-8848-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1390806273-8848-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jan 27, 2014 at 11:04:33AM +0400, Stanislav Kholmanskikh wrote:
> Most WDT driver modules return ENODEV during modprobe if
> no valid device was found, but w83697hf_wdt returns EIO.
> 
> Let w83697hf_wdt return ENODEV.
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
