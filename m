Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55657 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752198AbbHTSUm (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 20 Aug 2015 14:20:42 -0400
Date: Thu, 20 Aug 2015 11:24:07 -0700
From: David Cohen <david.a.cohen@linux.intel.com>
To: Pratyush Anand <panand@redhat.com>
Cc: linux-watchdog@vger.kernel.org, dyoung@redhat.com,
	dzickus@redhat.com
Subject: Re: [PATCH 24/37] watchdog: intel-mid: Fix parent of watchdog_device
Message-ID: <20150820182407.GA7113@psi-dev26.jf.intel.com>
References: <cover.1439524806.git.panand@redhat.com>
 <e7c5b17a597850192153e561be655596bf799be8.1439524806.git.panand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7c5b17a597850192153e561be655596bf799be8.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Aug 18, 2015 at 10:17:57AM +0530, Pratyush Anand wrote:
> Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
> is populated.
> 
> cc: David Cohen <david.a.cohen@linux.intel.com>
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> ---

Reviewed-by: David Cohen <david.a.cohen@linux.intel.com>
