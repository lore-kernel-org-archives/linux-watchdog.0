Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD191F03D9;
	Mon, 29 Jun 2026 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782740868; cv=none; b=SDP6/fbEPRzkla/YUWRhf45ZtAtOiWGJSkFuI1TlIUJEDrwUPTtsZ9UJMru+DWgsQliJghRiAy5L7qhasxMoPXQYTm25ScjXSmMK7Pr1545ZEIS9YUl6Ow23ozYz2R62vViT89EA3gBu5jq99UpQXJSItGeokeQ+3DqROIMZvLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782740868; c=relaxed/simple;
	bh=P2r9bk/6pe+LgcXtrlpYgWfXUkD+fNG1pjfD72yPBVw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FAWrK15hQmrAYTo9uNfR1H+AzrfntGeto8q3iAzAczDRdG6rCQaJpvgfh+/H5sq7poNa9VQmMlWGmMHI9mV7LEGLrUiB9Eeg5VzZDgJ7Z6yArfkM7glYqJcjG6wpplGe7Otor3EgX+DdzKIgqzse1e7cDHyQLsKSXqTFDpbpOQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=DE08V4NV; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DE08V4NV"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gpnf713hcz9tQ4;
	Mon, 29 Jun 2026 15:47:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782740863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2r9bk/6pe+LgcXtrlpYgWfXUkD+fNG1pjfD72yPBVw=;
	b=DE08V4NVuUQgxb0ZkOH+thskQv5tCLDI8JWueod3hB5zwU2lkP+LSeB253qhxOc8f9xw9B
	ypQBHkOOKB6z9uozg+Q0YaEHjMffOhvq0BMU3Oh1aOmmDs0Uc5nUM/idsLomWxSznYO5iA
	45qC6wEwxrd3aP4JhfQjwD9f1wDNaS9UByFB1s5ZF16YFfkEiAOWU8Aase8YngWfq/Slrz
	IllhtKSN2AQO6OWWT5tFejaKODfLTJ4xyLElSlMkWghV96/LHNYYhAV1ZMfthAFiSlbhiZ
	byxbcwNgIV6nGM90mjlq6Y+grtHDsgb/dKEXsblou9EsEY1R1PFrmSBY9WMxqQ==
Message-ID: <019ec0c2112fa0993a7935c824a18c89d86b4e24.camel@mailbox.org>
Subject: Re: [PATCH] docs: watchdog: Fix brackets
From: Manuel Ebner <manuelebner@mailbox.org>
To: Jonathan Corbet <corbet@lwn.net>, rdunlap@infradead.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux@roeck-us.net,
 skhan@linuxfoundation.org, 	wim@linux-watchdog.org
Date: Mon, 29 Jun 2026 15:47:38 +0200
In-Reply-To: <87pl19xy34.fsf@trenco.lwn.net>
References: <14d8a272b4d57b9e316a1351b38867417a2a6603.camel@mailbox.org>
	 <87pl19xy34.fsf@trenco.lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 17348f23aa45498385f
X-MBO-RS-META: 4f5r5cw54tqyb53fupexts98w4a89ahc

My bad, sorry.

 Manuel

On Mon, 2026-06-29 at 07:42 -0600, Jonathan Corbet wrote:
> Manuel Ebner <manuelebner@mailbox.org> writes:
>=20
> > Hi,
> >=20
> > is this patch on it's way?
>=20
> On its way where?
>=20
> You posted it two days ago, during the merge window.=C2=A0 Surely you do =
not
> expect action on it that quickly?
>=20
> jon
