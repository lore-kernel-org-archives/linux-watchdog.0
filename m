Return-path: <jcm@redhat.com>
Message-ID: <55F207FD.2030007@redhat.com>
Date: Thu, 10 Sep 2015 18:45:17 -0400
From: Jon Masters <jcm@redhat.com>
MIME-Version: 1.0
To: Timur Tabi <timur@codeaurora.org>, Guenter Roeck <linux@roeck-us.net>
CC: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com,
        linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, tekkamanninja@gmail.com,
        graeme.gregory@linaro.org, al.stone@linaro.org, hanjun.guo@linaro.org,
        ashwin.chaugule@linaro.org, arnd@arndb.de, vgandhi@codeaurora.org,
        wim@iguana.be, leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net
Subject: Re: [PATCH v4 5/7] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org> <1433217907-928-1-git-send-email-fu.wei@linaro.org> <1433217907-928-6-git-send-email-fu.wei@linaro.org> <556F4489.6030206@codeaurora.org> <20150603182503.GD6460@roeck-us.net> <556F4D29.1080001@codeaurora.org>
In-Reply-To: <556F4D29.1080001@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 06/03/2015 02:53 PM, Timur Tabi wrote:
> On 06/03/2015 01:25 PM, Guenter Roeck wrote:
>> In general the idea here would be to use a crashdump kernel, which,
>> when loaded, would reset the watchdog before it fires. This kernel
>> would then write a core dump to a specified location.
> 
> What is the mechanism for resetting the watchdog?  The only code that 
> knows about the hardware registers is this driver.  Does the crashdump 
> kernel call the watchdog stop function?
> 
>> If arm64 doesn't support a crashdump kernel, it might still be possible
>> to log the backtrace somewhere (eg in nvram using pstore if that is
>> supported via acpi or efi).

Just to go back and explicitly answer this, arm64 does have support for
crashdump, using the standard kexec/kdump approach, exactly as on x86.
There's still some more work to be done to get the ACPI case fully
upstream (e.g. on X-Gene platforms such as the HP ProLiant Moonshot m400
we need non-PSCI CPU parking protocol offlining when booting in
UEFI/ACPI mode), but it's what we are doing in RHEL(SA) and the goal is
to help clean up the remaining pieces upstream there.

Jon.
