Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED42A46C844;
	Tue, 22 Sep 2026 23:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790119361; cv=none; b=fKFkSVL1dh6tcY3WoDVHe4Hm7YfKA35mHvnmZiYmoTvqJAlV/f2oQAXnFUw6TVx09GF0vnG3yDj837W7Bv2gHNIOEfv/l5b6bm56PMP656mE/aJYTacAkP+kEY0VlXX0PCpFcVSvU/jOCb4/MYF5F1NCSydz6FvkpwPpbG5OOSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790119361; c=relaxed/simple;
	bh=PgefHW6QVEmndI6Pen8dca81L1s3Qu0KxcXBfMzPXEE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TJzY86iFP2AYPCTV6njvnrs8tUF6z7xhhq7GT9FONg1uqy2SGvHb2zbd0xIwLVV9NuNVI5jHKZ4mVetfsWBzadgA/U/xI7jxzGZ0A1w373n3p8jR2D4v2wHvXcaKsqm2VmizH1Xs0I28HXV8Dd14oHMIQS0Px2yHPhyk5ICF8kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TMayVCBU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TMayVCBU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9791F000FF;
	Tue, 22 Sep 2026 23:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790119359;
	bh=wKBWlI33FhDSPg+OguzLJJtT0RSFclrc6CAnfnG4Gpg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TMayVCBUUn2+3j7CQaLgmKWABkGrgi7VvoY7sV0yzsczNJz7RhDIMQJ+hqSyfa7Nw
	 TB/Ew/ajk/y+dOqwHcEZpP56tiwTQAe22/ZhB4gdkVHgRQBpqB9JhvFZvnnIHCc+la
	 ru7gS9EfY9+i7FMZ2kIXX0ehv0gP5uKad8V900j0=
Date: Tue, 22 Sep 2026 16:22:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: Petr Mladek <pmladek@suse.com>, Jinchao Wang <wangjinchao600@gmail.com>,
 Craig Lamparter <craig.lamparter@hpe.com>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/6] panic: fix panic_force_cpu= redirect races and
 NMI bypass
Message-Id: <20260922162238.5779a90e2d34853fc9fcc323@linux-foundation.org>
In-Reply-To: <6FCE58E3-B367-4258-8852-EB04335F9590@mainlining.org>
References: <20260916182957.7788-1-brads@mainlining.org>
	<arJ2KqCA7aBgt71r@pathway.suse.cz>
	<6FCE58E3-B367-4258-8852-EB04335F9590@mainlining.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 15:41:52 +0100 Bradley Morgan <brads@mainlining.org> wrote:

> On 22 September 2026 13:35:54 BST, Petr Mladek <pmladek@suse.com> wrote:
> >On Wed 2026-09-16 18:29:51, Bradley Morgan wrote:
> >> The panic_force_cpu= parameter redirects a panic to a specific CPU so
> >> the crash kernel runs there. The redirect code in panic_try_force_cpu()
> >> had two races and an NMI bypass, all found by Sashiko. This series
> >> closes them and kills one more hack that the rework turned up.
> >
> >IMHO, this version is ready to go. It would be great to fix the commit
> >message in the 4th patch but I think that Andrew could do the fixup.
> >
> 
> Akpm? Up for it?

Done, thanks.

