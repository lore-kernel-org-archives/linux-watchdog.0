Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:36727 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755729AbeCSPQp (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Mar 2018 11:16:45 -0400
Date: Mon, 19 Mar 2018 17:16:41 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-acpi@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] ACPI / watchdog: Fix off-by-one error at resource
 assignment
Message-ID: <20180319151641.GX2703@lahna.fi.intel.com>
References: <20180319135149.25215-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319135149.25215-1-tiwai@suse.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Mar 19, 2018 at 02:51:49PM +0100, Takashi Iwai wrote:
> The resource allocation in WDAT watchdog has off-one-by error, it sets
> one byte more than the actual end address.  This may eventually lead
> to unexpected resource conflicts.
> 
> Fixes: 058dfc767008 ("ACPI / watchdog: Add support for WDAT hardware watchdog")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
