Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:37246 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932560AbaDIMmx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 9 Apr 2014 08:42:53 -0400
Date: Wed, 9 Apr 2014 13:42:23 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: David Cohen <david.a.cohen@linux.intel.com>
Cc: wim@iguana.be, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] x86: intel-mid: add watchdog platform code for
 Merrifield
Message-ID: <20140409134223.6444a598@alan.etchedpixels.co.uk>
In-Reply-To: <1396990744-10695-3-git-send-email-david.a.cohen@linux.intel.com>
References: <1396990744-10695-1-git-send-email-david.a.cohen@linux.intel.com>
	<1396990744-10695-3-git-send-email-david.a.cohen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue,  8 Apr 2014 13:59:04 -0700
David Cohen <david.a.cohen@linux.intel.com> wrote:

> This patch adds platform code for Intel Merrifield.
> Since the watchdog is not part of SFI table, we have no other option but
> to manually register watchdog's platform device (argh!).

Before going too far down that path have you considered compiling in a
devicetree instead ?

Alan
