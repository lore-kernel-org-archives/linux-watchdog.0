Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792847974;
	b=WvFKkY9Ygwr877p1A/yDcq31BcJvt3/6xYRjPmIToyloE/qCOu9AoF0r+eBMzYAO7B0U
	 ABdjBmuNg5x1apP/lBocj1BwQB0UldNYHHgbPWk5I3NfQCdicZFIU3GS3zo/n8rwgb2FC
	 L9ghr9VAlOQeQuaTbpMkvefGi1znXkzg3ruX8+VZVkKfhWpcOPl5bKjdu9XOjEM12BT3K
	 NcNT+NSFMxUeNoh1z/usI9k2lIif0fgoGiBWJrNjC8sVfw4T8YGWVFBMmyh+OxRBDTeel
	 zqmqqlmavblwlIg+CyIqYhB6KKxKkXNtFnHufkgsg3clqXRRp577GZj+onrw3LQA04w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792847974;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=j5WSa/8IVYYHKaS0AnI9N3Ef17n2lXtV7Jz/TIMygzY=;
	b=gBb6DKk5x3URu8oahEX0IUoiXBD3gBTbHPocsCWssxP3bg867wDDghLRpH+2vRkpaV4q
	 CsQz34gI4chp0ilXT/H4IH1jO6XYud5/CG+EBvaZ1Kxb1BDIUTfC+C5PqTdz4DrfycRJs
	 7TYLdNBcA7DcaWvRTF1PLMCAPbbwv9P0fYcAz/oglFjJvhAv2PDopMCEUFcZbDOMljIjX
	 4exLyAksJ5jYp2ZU4wKMGQiM/vWdWAk06v/MIT3TOMSwf/plZx7k9BgyPbmgQY4jzfzwL
	 Vsk8S8HBhnwC2cQA+lQZQVmNaYA+82hrMUxFkSE2bKq+xFakRjXBvHwD15nPJcwYcgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhIndlgA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8860606A31A;
	Sat, 24 Oct 2026 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhIndlgA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743F01F031E1;
	Sat, 24 Oct 2026 13:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792847973;
	bh=j5WSa/8IVYYHKaS0AnI9N3Ef17n2lXtV7Jz/TIMygzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HhIndlgA5ht1us9eVUi9Uu+cfGJi+8NSSOZVNwCp1DlbTL9g8e2HK/+LU23C2vuEx
	 AGB0IrR4kBBKV+1sidfU0dVw2EBtGF1ZfegTTtfH0PlTwWGg3ve0Qex0c/Zcv2nLAX
	 5H9DBuAx7gdn971hZ42s4jML0aSv70t8fnL8hUpBjfPHFhxF0vtSrvNp7TJ5lGNYZ0
	 Se+u8eojqKQaErgdVjnEH/FCuRX8ZmuSc4OEIMGn4d9LPm9zp+9C586OLTyUZyfwN+
	 N9Soqw6SzhonrN4eqDpQgt0yBWicszpx6/NaoSwlSTOhWK2KTVMk0w2jdaxFIYN51a
	 In4RbJBwi6QJg==
Date: Sat, 24 Oct 2026 21:19:28 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, p.zabel@pengutronix.de,
	Sergey.Semin@baikalelectronics.ru, mika.westerberg@linux.intel.com,
	andi.shyti@kernel.org, iav@iav.lv, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] watchdog: dw_wdt: use
 devm_reset_control_get_optional_shared_deasserted
Message-ID: <atywYDiwxGu6Ik7A@tzungbi-laptop>
References: <20261022134354.534642-1-a.shimko.dev@gmail.com>
 <20261022134354.534642-2-a.shimko.dev@gmail.com>
 <atrO-ntRyvUMrKNE@google.com>
 <CAOPX745qshBW4NPh8cNt9kGUEtp6C1Ds8HVTjFjL2=q1azrFsw@mail.gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOPX745qshBW4NPh8cNt9kGUEtp6C1Ds8HVTjFjL2=q1azrFsw@mail.gmail.com>

On Fri, Oct 23, 2026 at 07:51:00PM +0300, Artem Shimko wrote:
> On Fri, Oct 23, 2026 at 6:05 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> 
> > The driver has been "quiet" in probe().  After the change, it starts to be
> > less quiet.
> 
> Thank you for your review.
> 
> It was based on other drivers (as example [1][2]) which use
> dev_err_probe() after
> devm_reset_control_get_optional_exclusive_deasserted() / reset_deassert().
> If you think this dev_err_probe() isn't needed, i can replace it with a return.

That would be great.  It seems v3 still preserves it.  I have no strong
opinion but just wanted to be consistent in the driver.

> 
> [1] drivers/i2c/busses/i2c-designware-platdrv.c:163
> [2] drivers/tty/serial/8250/8250_dw.c:731

---
Please reply-all next time so that the discussion remains visible to folks
on the mailing lists.
