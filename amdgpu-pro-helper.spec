Name:          amdgpu-pro-helper
Version:       0.1.1
Release:       1%{?dist}
Epoch:         1
License:       GPLv3
Group:         System Environment/Libraries
Summary:       Tools for amdgpu-pro stack in fedora

URL:           https://github.com/hazel-bunny/%{name}

Source0:       %{url}/archive/%{version}/%{name}-%{version}.tar.gz

BuildRequires: gettext
BuildRequires: python3-devel
BuildRequires: python3-rpm-macros

Requires:      /usr/bin/bash
Requires:      /usr/bin/rpmbuild
Requires:      fedora-packager
Requires:      rpmdevtools
Requires:      mock
Requires:      zenity

%description
Tools for installation and use of amdgpu-pro stack in fedora

%files
%{_bindir}/%{name}
%{_datadir}/%{name}
%{_datadir}/licenses/%{name}/LICENSE

#------------------------------------------------------------------

%package -n amdgpu-opencl-switcher
Summary:   Select needed OpenCL implementation with cl_pro prefix

Provides:  amdgpu-opencl-switcher = %{version}-%{release}
Provides:  amdgpu-opencl-switcher(x86-64) = %{version}-%{release}

Requires:  /usr/bin/bash

%description -n amdgpu-opencl-switcher
%summary

%files -n amdgpu-opencl-switcher
%{_bindir}/cl_pro
%{_datadir}/bash-completion/completions/cl_pro

#------------------------------------------------------------------

%package -n amdgpu-opengl-switcher
Summary:   Select needed OpenGL implementation with gl_mesa, gl_zink or gl_pro prefix

Provides:  amdgpu-opengl-switcher = %{version}-%{release}
Provides:  amdgpu-opengl-switcher(x86-64) = %{version}-%{release}

Requires:  /usr/bin/bash

%description -n amdgpu-opengl-switcher
%summary

%files -n amdgpu-opengl-switcher
%{_bindir}/gl_zink
%{_bindir}/gl_pro
%{_bindir}/gl_mesa
%{_datadir}/bash-completion/completions/gl_zink
%{_datadir}/bash-completion/completions/gl_pro
%{_datadir}/bash-completion/completions/gl_mesa

#------------------------------------------------------------------

%package -n amdgpu-vulkan-switcher
Summary:   Select needed vulkan implementation with vk_radv, vk_amdvlk or vk_pro prefix

Provides:  amdgpu-vulkan-switcher = %{version}
Provides:  amdgpu-vulkan-switcher(x86-64) = %{version}

Requires:  amdgpu-opengl-switcher
Requires:  /usr/bin/bash

%description -n amdgpu-vulkan-switcher
%summary

%files -n amdgpu-vulkan-switcher
%{_bindir}/vk_radv
%{_bindir}/vk_amdvlk
%{_bindir}/vk_pro
%{_bindir}/vk_legacy
%{_datadir}/bash-completion/completions/vk_radv
%{_datadir}/bash-completion/completions/vk_amdvlk
%{_datadir}/bash-completion/completions/vk_pro
%{_datadir}/bash-completion/completions/vk_legacy

#------------------------------------------------------------------

%prep
%autosetup -n %{name}-%{version}

%install
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_datadir}
mkdir -p %{buildroot}%{_datadir}/%{name}
mkdir -p %{buildroot}%{_datadir}/licenses/%{name}

mv src/bin/* %{buildroot}%{_bindir}/
mv src/share/bash-completion %{buildroot}%{_datadir}/
mv src/share/scripts %{buildroot}%{_datadir}/%{name}/
mv LICENSE %{buildroot}%{_datadir}/licenses/%{name}/

%py_byte_compile %{python3} %{buildroot}%{_datadir}/%{name}/scripts/%{name}.py

%changelog
* Thu Jul 20 2023 Dipta Biswas <dabiswas112@gmail.com> - 1:0.1.1-1
- Fix spec for copr

* Wed Jul 19 2023 Dipta Biswas <dabiswas112@gmail.com> - 1:0.1-1
- Initial release
