Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF5C222565;
	Mon, 29 Jun 2026 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782740537; cv=none; b=Go5mpSuwJPff1DRUezU3pWEEYyjP4DzqZZ39zXLRfqlnHBEwyBrL3qS2F0ns9a4HerdKNUCTmcxCqw8JPAWBzarVNDrvYH1rwt26PUjmdOlZoDrSLzpJTpGMbrN5OPWpXI2PGcW9ZDXNowj9yDkKD7wC0I0unj5m2ho2sEpikpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782740537; c=relaxed/simple;
	bh=mmtf0A7xzBvicHiaR8k96ma20BoqByKAARUwYePhH8M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l6/kfZa0SplP6EnV50V0LILuxPdnQAt/GItZHNcnlVt3ZQ2T2TrlxVjYQxNRtApVi1zrQZzquzEZPU8F6J23nBxE48t4luAmEXoksH5JL4vA59fzTJi2IGwi4qRLhRSR23WIiFVF3VHuh+O+ua11w/nOdv3qA1czko7A9ly+qks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=XeVkzgxW; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="XeVkzgxW"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B305840E59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1782740528; bh=9UDS1rBClB2zraXdgOpykIMV5rwaSbg+XI7SiZ1Ajtk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XeVkzgxW0tNo0IDORLSuyWoeetBly8YWq0OSdcSsBZ/cH9oEuW3tl1Cz0++MASDq9
	 z+h7cy7LjEuuxKOMcyd7Xxy7/2n4tJQPmvmXl2AdOvPPYplPvxfHEpJ+ak+m0UTeBk
	 J8FVt39RBjDQrR2Jkv5ByUS1glWZnnMmZQlIyuVFmk1CKXd51G7zNX2uNTNfCKftgc
	 +z1sSqFoPYJF8yDedntl2fccaQ2tcdQY+pxS3d2MEQOdBpfIquhP1Qdnjumo30Psrt
	 l7u3dMPaW2InoiUjYC5gYNhu6h1USP8G4UcF7ql0UUxhuwHz2JZkAVt+Ev0hRRkZNz
	 6U2MYITxNtHFQ==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B305840E59;
	Mon, 29 Jun 2026 13:42:08 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Manuel Ebner <manuelebner@mailbox.org>, rdunlap@infradead.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux@roeck-us.net,
 manuelebner@mailbox.org, skhan@linuxfoundation.org, wim@linux-watchdog.org
Subject: Re: [PATCH] docs: watchdog: Fix brackets
In-Reply-To: <14d8a272b4d57b9e316a1351b38867417a2a6603.camel@mailbox.org>
References: <14d8a272b4d57b9e316a1351b38867417a2a6603.camel@mailbox.org>
Date: Mon, 29 Jun 2026 07:42:07 -0600
Message-ID: <87pl19xy34.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Manuel Ebner <manuelebner@mailbox.org> writes:

> Hi,
>
> is this patch on it's way?

On its way where?

You posted it two days ago, during the merge window.  Surely you do not
expect action on it that quickly?

jon
