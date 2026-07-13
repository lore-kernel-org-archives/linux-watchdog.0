Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B17E437474;
	Mon, 13 Jul 2026 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953322; cv=none; b=k5laGXV4eb4gtlxziTrxhtsjOJwt12cxe2OC5pREjwaxj/Um/JG33g9mbyb+5rQOQdIbnF0UNjDi6cTuzhnyJO6zRjKhp1LnrC6UOhK1VgtIa6CI0U55Yv0JFDncQgfY/eGwD53EpkX9d19/jop3TbLfdMdigSDA8WgoiVY0I7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953322; c=relaxed/simple;
	bh=BZPDp00nmoGQ1vQhnZjTGZrCaeMPbdual5nys+YYARs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GDy3Z4RS7tc2ykXZh6BAIhmUYLUUyuny66mE5Baqs8D2H7mA+Cylju6VUlnteLcXj9N/mdqvDHktgKMZTxxhJcGCq8vUpZXAgJAlVYnbWDHmOeT44bCER9j5/bMR+zlX/dVahpvh0SubR8k9I8FdPScUMq3pGuVPO+MMmJlUZq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (2048-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=Hb3JL6JU; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Hb3JL6JU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
	s=protonmail; t=1783953310; x=1784212510;
	bh=BZPDp00nmoGQ1vQhnZjTGZrCaeMPbdual5nys+YYARs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Hb3JL6JUtHil8Wlpvt2y4a7Y/c5fCd/1InrsRb7Sm3DE5nP8PRwiCNWhWn9wctCF0
	 P41/CEGy59dWzj7Mz0fMCd2ODdjgagGcUX4iBA9Zqi504TFOtXr7cW2ZcPnWPI8NKH
	 NhbBQZ72Xvun+r/8UMZNqpUx0kPGEqdND9aUfNc97DiNXdw+ikMWHNlVk7pJzgFy9w
	 82E8bYWswzl/aIdvr3eg+MYpkr/Y9UchnkqnXevY6yksM1wj5fBV4G4StpMt3nnYEU
	 L5Bmx/pob8ynUoMqe1GU04fEFeAkYHPPJ2+mPHBP+1Y89mWaP3EntVA/smLKsUI4xF
	 v1BqbJbEa/yqA==
X-Pm-Submission-Id: 4gzQ2N68YXz1DDpB
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: "Guenter Roeck" <linux@roeck-us.net>
Cc: "Wim Van Sebroeck" <wim@linux-watchdog.org>,
  <linux-watchdog@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] watchdog: take all OF aliases into account when
 assigning id
In-Reply-To: <15a059c9-b922-4d10-9ee2-3f362b5b603c@roeck-us.net> (Guenter
	Roeck's message of "Wed, 08 Jul 2026 07:53:46 -0700")
References: <20260615145759.3142743-1-linux@rasmusvillemoes.dk>
	<XobowKxdtG0mvqTiTZwSy1NPXSqtqQ8RTLdptdSlr8eYOPRHb5vtY7LlqR2d1K52jmreEvSFNhVkmbyOAvW9JQ==@protonmail.internalid>
	<15a059c9-b922-4d10-9ee2-3f362b5b603c@roeck-us.net>
Date: Mon, 13 Jul 2026 16:35:07 +0200
Message-ID: <87se5nrm90.fsf@rasmusvillemoes.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 08 2026, "Guenter Roeck" <linux@roeck-us.net> wrote:

> On Mon, Jun 15, 2026 at 04:57:59PM +0200, Rasmus Villemoes wrote:
>> If some, but not all, watchdog devices have device tree aliases, those
>> without aliases might (depending on probe order) be assigned an id
>> which would otherwise be assigned to one of those with an alias.
>>
>> This is problematic when for example watchdog0 is an alias for an
>> always-running gpio watchdog that userspace must handle, but the SOC's
>> watchdog device(s) get probed first and thus one of those become
>> /dev/watchdog0.
>>
>> Ensure that ids for devices without a device tree alias are allocated
>> from above the highest numbered alias, if any.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>>
>> This is similar to how the mmc, i2c, i3c and spi subsystems handle
>> device tree aliases and avoid using an id that might be assigned to a
>> device/bus that is probed later.
>
> The patch makes sense. Unfortunately, there are systems with aliased
> watchdogs which do not enable "watchdog0" (e.g., several Nuvoton based
> boards). On such systems, if they do have an unaliased / auto-generated
> watchdog, /dev/watchdog0 and with it /dev/watchdog would no longer be
> created. This would result in a ABI break.
>
> On top of that, the patch only affects systems with both aliased and
> un-aliased watchdogs, which makes me even more concerned.

Well, yes, the problem only occurs on exactly such systems.

- If all enabled watchdog devices have DT aliases, they all get their
assigned id.

- If no wathcdog device has a DT alias, they'll just get sequentially
assigned ids in probe order, and none of them will "accidentally" get an
id that should be assigned to a device with a DT alias.

> To apply this or a similar patch, we would have to ensure that there
> is no enabled watchdog with ID == 0.

I'm not sure I completely understand your concern(s), but I can see that
if there is any watchdog DT alias, we'll never use id 0 except if there
is a watchdog0 DT alias (and that device is actually enabled).

What if instead of assigning dynamic ids from above the highest existing
alias, we assign a dynamic id as usual, but skip existing aliases? So if
there's a watchdog1 alias, but no watchdog0 alias, the first unaliased
watchdog device being probed would become /dev/watchdog0 and hence
/dev/watchdog. Would that work?

Rasmus
