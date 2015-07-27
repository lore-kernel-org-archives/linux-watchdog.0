Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53388 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbbG0Tg3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jul 2015 15:36:29 -0400
Date: Mon, 27 Jul 2015 12:36:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com
Subject: Re: [PATCH] watchdog: (nv_tco) add support for MCP79
Message-ID: <20150727193626.GB14674@roeck-us.net>
References: <1438013010-23618-1-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438013010-23618-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jul 27, 2015 at 12:03:30PM -0400, Vivien Didelot wrote:
> Tested on the Nvidia chipset with an SMBus controller PCI ID 0x0AA2
> (as shown in the PCI listing during the boot sequence).
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
