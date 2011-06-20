Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:62234 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754630Ab1FTOoH (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 20 Jun 2011 10:44:07 -0400
Date: Mon, 20 Jun 2011 16:44:09 +0200
From: Samuel Ortiz <sameo@linux.intel.com>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/2] Add tunnelcreek watchdog to lpc_sch devices
Message-ID: <20110620144409.GN22420@sortiz-mobl>
References: <1308222350-21634-1-git-send-email-alexander.stein@systec-electronic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1308222350-21634-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Alexander,

On Thu, Jun 16, 2011 at 01:05:49PM +0200, Alexander Stein wrote:
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
I guess it's about time to implement a routine for the pci_read_config_dword()
-> convert to base_addr -> set resource pattern.
I applied your patch though, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
