Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:60984 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753508AbcLUHUg (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 21 Dec 2016 02:20:36 -0500
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: sa11x0/pxa: fix error path of driver initialization
References: <20161221011816.3809-1-vz@mleia.com>
Date: Wed, 21 Dec 2016 08:20:25 +0100
In-Reply-To: <20161221011816.3809-1-vz@mleia.com> (Vladimir Zapolskiy's
        message of "Wed, 21 Dec 2016 03:18:16 +0200")
Message-ID: <87d1gld9za.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Vladimir Zapolskiy <vz@mleia.com> writes:

> The change corrects release of captured resources on error path, namely
> the clock is disabled and put if misc device registration fails and not
> enabled clock is not disabled now.

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
