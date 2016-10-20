Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33081 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbcJTWTj (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 20 Oct 2016 18:19:39 -0400
Date: Thu, 20 Oct 2016 15:19:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] watchdog: wdat_wdt: Ping the watchdog on resume
Message-ID: <20161020221931.GA929@roeck-us.net>
References: <20161020150336.97791-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161020150336.97791-1-mika.westerberg@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Oct 20, 2016 at 06:03:36PM +0300, Mika Westerberg wrote:
> It turns out we need to ping the watchdog hardware on resume when we
> re-program it. Otherwise this results inadvertent reset to trigger right
> after the resume is completed.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

[ assuming Rafael is going to pick it up ]

Guenter
