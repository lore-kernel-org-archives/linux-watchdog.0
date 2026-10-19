Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423344;
	b=fP2eRXk7s+2AQWXFCbo+dQNFF/hdMvjoPyLlu5U45Ewgzt3pyCUS/BuXuF064Xp2crYJ
	 IrUjp2398tHnZA1J54ot2pKWiL6OPftQcCRwl4H+QZZhAoy0ckiLmv/UhyL4lu8g0vqVa
	 m5s5hzcBdIS3+n5waIUXt49GcLsG4nQiAw3Xf066axxp0o0qOONP1gGpKSUecXhyLSRMc
	 btybf4w/cz6fsVHjvuBidtUpGesrBamAzM9KINW6cpcmpj5sE583CW2V6c4xwvoN+VOTh
	 PhMxdyEx8f4KjyZBUsAD4y9gfX8nttr07t6cIOvROEHzU+zOY360cuvM2C4bCTcX2JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423344;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XyXvG3jlmWxZi6RfeBv4p+ehPLAnkTi8by21O1chM7s=;
	b=zBDh+xBDNwv7Np1c5t9lVeBiiFIGKFfza5zvLB8nx6AXzbWWU/u7hYbWZBSDtMN82Ja4
	 5ofX00uhAqCjwq+q8n1yM1bQFu4URAPRseaOD6PgtRqKobPiyUmJvTvbjvwTpKRDuI0r3
	 hr/0/aSiiajRMByRMPs5GdhWFihpqPvpBX5rW7HQCKlBMLrMVf7oYHUNPiwVjDcn/RhGH
	 lgU4FBuRFGYMwNMn9Ctketbn2GFMsqglULDJYqTj3aoyOaa/TgiFvGqPDu/PrDRmUHZEE
	 yOTHV03qb2Mohzzdq4zNnrIX9GRbl4k34EgJB4sPfE3mmXm57adGCVlcJ47is/FDjbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eIeSbhkx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A6C60AA0EB;
	Mon, 19 Oct 2026 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eIeSbhkx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189FE1F000C4;
	Mon, 19 Oct 2026 15:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792423344;
	bh=XyXvG3jlmWxZi6RfeBv4p+ehPLAnkTi8by21O1chM7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eIeSbhkxIjF4KcP+WAzlEDlQOp/iAZXVwFuLFNRhl1DLMZ6O4bro/ViKqtVAJ5X8X
	 CPLTe3jvfdBIrd7OrQmk5d+Yw/l9fpSFR2CTJAPTa1+tGYrgD4EuwkARHzEDcgZype
	 vNnh0CQPDhOZZH4IVtpJFGaXWzWLOx3BEpBQd6HF1UF/Dz3tUD18i6LzquBUeE9XZt
	 A4UJihUPBYCuOgGbdDWlnCB+9WJJb/9V1USKIi+o+usGKXGBuhrHr03iYYwhxAv+ki
	 bQAzWqjRXE9gA+pDvh60juS89SsxvrZlRLNkNTTQtYsYHBOlXaV+Jtfk3tqgCAt3Fd
	 syvpAAxPtYYCw==
Date: Mon, 19 Oct 2026 15:22:21 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Paul Louvel <paul.louvel@bootlin.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 2/6] watchdog: w83627hf_wdt: Replace magic numbers
 with descriptive macros
Message-ID: <atY1rXhHo2RJbDrF@google.com>
References: <20261013-w83627hf_wdt-improvements-v4-0-b6f6b60a9566@bootlin.com>
 <20261013-w83627hf_wdt-improvements-v4-2-b6f6b60a9566@bootlin.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013-w83627hf_wdt-improvements-v4-2-b6f6b60a9566@bootlin.com>

On Tue, Oct 13, 2026 at 03:58:46PM +0200, Paul Louvel wrote:
> Raw hex values for Super I/O register addresses are difficult to
> understand
> without constantly consulting the datasheet. Use named macros instead.
> Also, replace macros value that contains bit position with the BIT()
> macro.
> Remove comments that doesn't help understanding the code.
> 
> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>

This looks good to me.  Except for a weird line wrap in the commit message,

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
