Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188FE296BBC;
	Fri, 31 Jul 2026 21:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785531704; cv=none; b=FTSKfu32Lf64H8JrwhImf8BjX2TNiu5W+DWpRskoy/vMpcKawabta7R4mJVmz7h/6DGDpJ0vj0kQ6+P54rwLpv7UoE9heQ1vDCuWXA/LYpjt3cKrxZNhjuC34rPS36kFf6ULaIpYfiFjsL5sBLUZxcXTroZLCcnq6oN8E6cxmwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785531704; c=relaxed/simple;
	bh=ig0yJrYb7eWc5Urp/MhKMekjVNFMMWvVBLE8u/4AW8w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=F8m1a2T9z7qDbXIfSb1nReuT/uBUA3aa+0HzCtt0ntp50DuO5W0KsaljmeBoq/RN2HD2PRPcXQySwhi5MC5ardbPwoJ4Iwqb20Nm4mkX6kpuFcDAjudS/NxsrVX36Cy/wsCuHLSrXn+TCuXPhk6V0kUH08M8YW93WZ66v6o7e+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GVQh+CMs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GVQh+CMs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D6A1F00ACA;
	Fri, 31 Jul 2026 21:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785531702;
	bh=QQhxAsBuJ0/HqwB70/NyY0+3TWumPMEqvJA/HaqNKM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GVQh+CMsTQlScSg+ENURqmXxxwMYX1zSuSt/a6NOxSZx7lAznZmVHL2MMU70SySIe
	 xA5MpnXbGNQHggGxSksJLcgj15dgJVtBtWsIfd9iIkUA5o28BxB6URgjgnqCcEVlZM
	 Rvx5xrNe9+h39rY5mtL9jTnDYZbyS6KznaBYW+FY=
Date: Fri, 31 Jul 2026 14:01:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mayank Rungta <mrungta@google.com>
Cc: Mayank Rungta via B4 Relay <devnull+mrungta.google.com@kernel.org>, Wim
 Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
 Tzung-Bi Shih <tzungbi@kernel.org>, Douglas Anderson
 <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 0/2] watchdog: pretimeout: Allow building dump governor
 as module
Message-Id: <20260731140142.7d77cfd7e9f99f25880efd32@linux-foundation.org>
In-Reply-To: <CABz7rdCZkzBv-horH0jNLeNuhCNUOaC+Ttkf_-g3CoCaCSfBbg@mail.gmail.com>
References: <20260730-export-cpu-backtrace-apis-v1-0-bace8e1cb817@google.com>
	<20260730155021.8252ad9d155b472702e66755@linux-foundation.org>
	<CABz7rdCZkzBv-horH0jNLeNuhCNUOaC+Ttkf_-g3CoCaCSfBbg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 30 Jul 2026 16:39:14 -0700 Mayank Rungta <mrungta@google.com> wrote:

> On Thu, Jul 30, 2026 at 3:50 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Thu, 30 Jul 2026 15:00:20 -0700 Mayank Rungta via B4 Relay <devnull+mrungta.google.com@kernel.org> wrote:
> >
> > > All other watchdog pretimeout governors (noop, panic) can be built as
> > > loadable modules. However the "dump" pretimeout governor is restricted
> > > to built-in code because it calls trigger_all_cpu_backtrace(), which
> > > relies on arch_trigger_cpumask_backtrace(), an arch specific helper that
> > > is not exported to loadable modules.
> > >
> > > This 2-patch series allows building the dump governor as a module (=m):
> > > 1) Export cpumask_backtrace() in lib/nmi_backtrace.c.
> > > 2) Convert CONFIG_WATCHDOG_PRETIMEOUT_GOV_DUMP from bool to tristate.
> >
> > LGTM.  Can you please redo against current mainline?  The Kconfig has
> > changed.
> >
> 
> Thanks for the LGTM!
> 
> Regarding rebasing onto mainline (origin/master): The "dump"
> pretimeout governor was added recently by Tzung-Bi Shih ("watchdog:
> pretimeout: Add "dump" pretimeout governor") and is currently in
> linux-next, so it hasn't landed in mainline tree yet.
> 
> Because of this dependency, I based this series on linux-next so that
> patch 2/2 ("Convert dump pretimeout governor to tristate") could apply
> cleanly on top of the new governor.
> 
> Please let me know what is preferred, or if you'd like me to post
> against a different tree!
> 

Oh, OK.

Guenter, can you please process this patchset?
